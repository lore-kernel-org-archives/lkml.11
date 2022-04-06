Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686D5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 17:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiDFRit (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbiDFRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:38:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2777347981
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95997B82418
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596A3C385A1;
        Wed,  6 Apr 2022 15:46:56 +0000 (UTC)
Date:   Wed, 6 Apr 2022 11:46:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Bluetooth: hci_qca: Use del_timer_sync() before freeing
Message-ID: <20220406114654.3c0e17a8@gandalf.local.home>
In-Reply-To: <20220406153907.GA1994259@roeck-us.net>
References: <20220404182236.1caa174e@rorschach.local.home>
        <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
        <20220406153907.GA1994259@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 08:39:07 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > ie move this destroy_workqueue() up ?
> >   
> 
> What prevents the timer code from queueing work into the destroyed
> workqueue ?

So we have a chicken verses egg issue here?

-- Steve
