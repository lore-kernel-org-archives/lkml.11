Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09857C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 06:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiEXGuo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiEXGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:50:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A418FF88;
        Mon, 23 May 2022 23:50:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 18C3E2190B;
        Tue, 24 May 2022 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653375041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fIPv/3QXIG9Ts3K/tDWixM7b7yDQ6eetHp3lhHIOR2w=;
        b=XPHF96k4TtBeKCL5+OOkDbP2YRLcO6XqdL+W7lBXYEewj9/C1iI8eAFd6LdWTvCSNCuSiR
        ofaEWfu2URCCDyTAAKVYiHjjulhDNmPWGFzOJXlwXkJKn22WONVdsQX9m31+JRUdt7xNE3
        EirGPdmcge0eTv0ric5pctEyh2EOOm8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AB2382C141;
        Tue, 24 May 2022 06:50:40 +0000 (UTC)
Date:   Tue, 24 May 2022 08:50:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the livepatching
 tree
Message-ID: <YoyAPVrztxBvxn4v@alley>
References: <20220524083455.666052d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524083455.666052d5@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-05-24 08:34:55, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   1751eacf9794 ("livepatch: Remove klp_arch_set_pc() and asm/livepatch.h")
> 
> is missing a Signed-off-by from its committer.

Grr, thanks a lot for catching this.

It should be fixed now.

Best Regards,
Petr
