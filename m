Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D0C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 12:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbiBWMRy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiBWMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:17:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FB7517E6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:17:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 125F6212B8;
        Wed, 23 Feb 2022 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645618642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCTn1wtAYKsqIpLotJVAPK/XJ5F77c4RNzGbAdvDnk0=;
        b=sdhszPEKJfA6zVcPpF5CRDue+pHJhDJoG9jfBC6w3SfqsEP7C1j0YLOv0uVnNrs1LN53XJ
        Hg3PRZcVnWyN4NRPIKi4EqFlzZPfNWA8PDtMda7FkFhv9JC571QmopAuEH5hABrZ5VLjID
        3jQj7AieU4WF1CuhrRxNx4DbCgdP2tg=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E0EF3A3B81;
        Wed, 23 Feb 2022 12:17:21 +0000 (UTC)
Date:   Wed, 23 Feb 2022 13:17:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 12/13] printk: remove @console_locked
Message-ID: <YhYlz8l0jZVeUXrq@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-13-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-13-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:22, John Ogness wrote:
> The static global variable @console_locked is used to help debug VT
> code to make sure that certain code paths are running with the
> console_lock held. However, this information is also available with
> the static global variable @consoles_paused (for locking via
> console_lock()), and the static global variable @console_lock_count
> (for locking via console_trylock()).
> 
> Remove @console_locked and update is_console_locked() to use the
> alternative variables.

It is great that we are also removing something ;-)

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
