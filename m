Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD24FC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 May 2022 12:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346868AbiEAMGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 May 2022 08:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346812AbiEAMGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 08:06:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFD623172
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 05:02:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 616181F37D;
        Sun,  1 May 2022 12:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651406576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XeEhQOWWCLlX3LSi/+DtKP/Gt0eJFA51Mt6j3zosrCg=;
        b=c78j+NimgSv3PHFqsFBarilaQsXVSkJbzMjRAbt4In17G5lLdDioKivU+HDM8EF3rgvFqR
        cTnxkqrR/DmXL64rIThHqqqyqRH9BqWNxqZ2IlpAbR4aYTbIP6XV7rMiBLUDEbphSCeoae
        UHZgAIVVXrgYQ2m7aaBhC8wRM5gGBcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651406576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XeEhQOWWCLlX3LSi/+DtKP/Gt0eJFA51Mt6j3zosrCg=;
        b=xNvpea4P/xl+rqB/HAswY4aA7arko8BM0IbDqkmDOdJBd9dIJT0bDjfo32WnD0qa7wzinJ
        0H9OobfmEc2lVxCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 562EF139F5;
        Sun,  1 May 2022 12:02:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6hL4FPB2bmKHNQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 01 May 2022 12:02:56 +0000
Date:   Sun, 1 May 2022 14:02:57 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Ozgur Karatas <ozgurk@ieee.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] irq/urgent for 5.18
Message-ID: <Ym528eZ5kb2geWwx@zn.tnic>
References: <Ym5vDU6KFdzYaTAo@zn.tnic>
 <CAADfD8ypPRzja3RU8QGwBNc=MiN1H3OLHjHVgnJ6h1fFPO2dhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADfD8ypPRzja3RU8QGwBNc=MiN1H3OLHjHVgnJ6h1fFPO2dhw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 03:52:25PM +0400, Ozgur Karatas wrote:
> shouldnt this actually be a return error = -EINVAL?

Why?

What is the return type of fsl_mc_msi_domain_alloc_irqs()?

That is, provided I understand your question. Because I'm not really
sure what you're asking...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
