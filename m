Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91287C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 08:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiCRIwv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiCRIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:52:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7F4FFFA3;
        Fri, 18 Mar 2022 01:51:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BAAB11F37F;
        Fri, 18 Mar 2022 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647593485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dCd/2Xnvy12wap7uukyIoQcrVYhnZ+Ii3tvlTmlfPLk=;
        b=k97XBkdOaWpyObRAY2A3efiSjth20cgIVnSJQNd15wy6q1cdlY+nFA1EaOz+nxacAHEr3F
        KpOVYJpaQB+aC9So0sAltiUIfY3DuwYYS3giwbbc5YOt55GEUCL5fdBq1c5jooAmonwQWG
        X81uZz2J11iIjz+9Td+Z1as7MnSEGv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647593485;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dCd/2Xnvy12wap7uukyIoQcrVYhnZ+Ii3tvlTmlfPLk=;
        b=dHaEv1N9LKhMerX3XKzfPCSifvdq3jm1bKkyZtMXKkz15Dp5xvPukA6TNcS9OUNzMWkhn4
        yyMyTnRaqJ/7YgDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7437913BB5;
        Fri, 18 Mar 2022 08:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TLWtGg1INGI0MgAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 18 Mar 2022 08:51:25 +0000
Date:   Fri, 18 Mar 2022 09:51:23 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Peter Gonda <pgonda@google.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sev-es: Replace open-coded hlt-loop with
 sev_es_terminate()
Message-ID: <YjRIC/16QE2jXSkM@suse.de>
References: <20220317211913.1397427-1-pgonda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317211913.1397427-1-pgonda@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:19:13PM -0700, Peter Gonda wrote:
> Replace the hlt loop in handle_vc_boot_ghcb() with an
> sev_es_terminate(). The hlt gives the system no indication the guest is
> unhappy. The termination request will signal there was an error during
> VC handling during boot.
> 
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Gonda <pgonda@google.com>
> ---
>  arch/x86/kernel/sev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index e6d316a01fdd..ae87fbf27724 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1425,6 +1425,5 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>  fail:
>  	show_regs(regs);
>  
> -	while (true)
> -		halt();
> +	sev_es_terminate(GHCB_SEV_ES_GEN_REQ);

Reviewed-by: Joerg Roedel <jroedel@suse.de>

