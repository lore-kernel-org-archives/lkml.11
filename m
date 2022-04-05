Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F35C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 01:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiDECAf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 22:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiDECA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D63571FD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB6D61793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4482C2BBE4;
        Tue,  5 Apr 2022 01:07:48 +0000 (UTC)
Date:   Mon, 4 Apr 2022 21:07:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Bluetooth: hci_qca: Use del_timer_sync() before freeing
Message-ID: <20220404210746.32bb4df6@rorschach.local.home>
In-Reply-To: <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
References: <20220404182236.1caa174e@rorschach.local.home>
        <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022 17:22:00 -0700
Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index f6e91fb432a3..73a8c72b5aae 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -696,8 +696,8 @@ static int qca_close(struct hci_uart *hu)
> >   	skb_queue_purge(&qca->tx_wait_q);
> >   	skb_queue_purge(&qca->txq);
> >   	skb_queue_purge(&qca->rx_memdump_q);
> > -	del_timer(&qca->tx_idle_timer);
> > -	del_timer(&qca->wake_retrans_timer);
> > +	del_timer_sync(&qca->tx_idle_timer);
> > +	del_timer_sync(&qca->wake_retrans_timer);  
> 
> 
> It seems the wake_retrans_timer could be re-armed from a work queue.
> 
> So perhaps we need to make sure qca->workqueue is destroyed
> 
> before these del_timer_sync() calls ?
> 
> >   	destroy_workqueue(qca->workqueue);  
> 
> 
> ie move this destroy_workqueue() up ?

Yeah, that could be a problem. I would think moving it up would help,
if that's what requeue's the timers.

-- Steve


> 
> 
> >   	qca->hu = NULL;
> >     

