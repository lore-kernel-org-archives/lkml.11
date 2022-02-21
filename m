Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E21C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 15:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379550AbiBUPtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 10:49:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379526AbiBUPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:49:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7F2458C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:49:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A1B9D21129;
        Mon, 21 Feb 2022 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645458556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iAqz2GmqnpNP4dAnFjtbOp+KfoSTEli02wVy6WIU/sY=;
        b=bGHFABVNObcxZuIpeS/MkEkEKjLs4+FDmQEX/eZIGet7JNcND34wTM20p8UXfCSEMgbqaK
        3UDaIdtTsAjvkHeCxZkMrCuNEfZJT5p7icOEoT9zh+2+gu5iEm5paHphUiVxITqB6Zu5GX
        /3w5i5TXlqdJE2m6LjSZ4DtmSiDalAY=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4943EA3B84;
        Mon, 21 Feb 2022 15:49:16 +0000 (UTC)
Date:   Mon, 21 Feb 2022 16:49:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andre Kalb <andre.kalb@sma.de>
Cc:     senozhatsky@chromium.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3] printk: Set console_set_on_cmdline=1 when
 __add_preferred_console() is called with user_specified == true
Message-ID: <YhO0fBJLn4hW2LyC@alley>
References: <YgxtGWh0b9NXTyu8@google.com>
 <YgzU4ho8l6XapyG2@pc6682>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgzU4ho8l6XapyG2@pc6682>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-02-16 11:41:38, Andre Kalb wrote:
> From: Andre Kalb <andre.kalb@sma.de>
> 
> In case of using console="" or console=null
> set console_set_on_cmdline=1 to disable "stdout-path" node from DT.
> 
> We basically need to set it every time when __add_preferred_console()
> is called with parameter 'user_specified' set.
> Therefore we can move setting it into a helper function that is
> called from __add_preferred_console().
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Andre Kalb <andre.kalb@sma.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

The patch is comitted in printk/linux.git, branch for-5.18.

Best Regards,
Petr
