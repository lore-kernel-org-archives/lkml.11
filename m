Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C012BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 18:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiDFSLy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbiDFSJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:09:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0601E9972
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC1161763
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BD1C385A1;
        Wed,  6 Apr 2022 16:46:46 +0000 (UTC)
Date:   Wed, 6 Apr 2022 12:46:45 -0400
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
Message-ID: <20220406124645.3a1ce66e@gandalf.local.home>
In-Reply-To: <59941012-6eb6-91f3-ac79-cca759fa53d7@roeck-us.net>
References: <20220404182236.1caa174e@rorschach.local.home>
        <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
        <20220406153907.GA1994259@roeck-us.net>
        <20220406114654.3c0e17a8@gandalf.local.home>
        <59941012-6eb6-91f3-ac79-cca759fa53d7@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 09:36:10 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > So we have a chicken verses egg issue here?
> >   
> 
> Almost looks like it, unless I am missing something. Maybe some flag
> is needed to prevent the timer handling code from queuing into the
> destroyed workqueue, or the workqueue handler from updating the timer.

That's exactly what I was thinking. I do not know all the code here. I
could try to write a patch, but I may likely miss something.

-- Steve
