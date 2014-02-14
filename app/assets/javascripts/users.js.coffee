$ ->
  $('img[data-failover]').error ->
    failover = $(this).data('failover')
    if this.src != failover
      this.src = failover
