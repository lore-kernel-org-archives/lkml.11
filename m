Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271E1C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 13:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381509AbiEMNhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 09:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381284AbiEMNeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:34:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E132663B8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:34:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFA071F904;
        Fri, 13 May 2022 13:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652448853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDJZar56lzTheHzjbbIajAJWdJ4wgWvDaqV7f4rkCRo=;
        b=D1LJM/ZXh3F36LL08QDC3YgQIfFBisJ9gZ2U+0J2ikeUgkJZFy9jGH4GKV5lh+Gu64DTUb
        Xm8veebY2ta1jqFwCcPDwNDctUfsGaYw9/HCyvdQ1nd6BH1sUIX6C4Mmm/MoLKOph4WHjx
        7ZTXMLaeDT6diwP93DStjT0oa/VpKJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652448853;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDJZar56lzTheHzjbbIajAJWdJ4wgWvDaqV7f4rkCRo=;
        b=goV9CK2QaWzK4JKz/rU94eht9BS6SsmtekY4TQVEW1OqmTZFgE8/4enG7OzsdtOJSraYCP
        SlP3NYNmw4by8XDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D80113446;
        Fri, 13 May 2022 13:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B5/6HFVefmKdcwAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 13 May 2022 13:34:13 +0000
Date:   Fri, 13 May 2022 15:34:12 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V2] x86/sev: Mark the code returning to user space as
 syscall gap
Message-ID: <Yn5eVA07T4oTkTLl@suse.de>
References: <20220412124909.10467-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412124909.10467-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 12, 2022 at 08:49:08PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> When returning to user space, the %rsp is user controlled value.
> 
> If it is SNP-guest and the hypervisor decides to mess with the code-page
> for this path while a CPU is executing it.  This will cause a #VC on
> that CPU and that could hit in the syscall return path and mislead
> the #VC handler.
> 
> So make ip_within_syscall_gap() return true in this case.

With the SNP guest patches in tip-tree I think it actually becomes
possible that a #VC exception hits in these parts of the execution
stream. It requires good timing by the attacker, but it is not
impossible. Therefore:

Acked-by: Joerg Roedel <jroedel@suse.de>

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
 
(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev

