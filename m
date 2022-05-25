Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6371DC4332F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 20:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344670AbiEYUg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiEYUgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:36:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA0F18B31
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 174046186E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A54C34117
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:36:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N97LzN21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653510977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8C6I5Q0ZOUAwk3pFTbjZ83irwPDvFOCUcomxT5QCekE=;
        b=N97LzN21ROmlBC6fmLyx0f5isH9GdcwF2m3Dsd2Gl47CSVDq/bBSdKzlKppei9d8+77iId
        fpcAinDWwtIr2RNaIbUHv4if06ta5K/3OwAHYM3OhES8Oolk7SOmm7VGfpDGKHYIqPxGM2
        f1eEkVsl0s9dt5KFVtuIjCVLm/Db3qM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c3c0ee9c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 25 May 2022 20:36:16 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id x2so37887858ybi.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:36:16 -0700 (PDT)
X-Gm-Message-State: AOAM5305c74SEdd0JbrqbAEf9XvC0vL5Nez66k/R8F/y6d25UI1JdKfA
        KraziTU80VQb5BQ1NOmW4Ff5fI6OyxZBbgGNXDg=
X-Google-Smtp-Source: ABdhPJwny8dWghQuS8G19VvnRTdg+tdPKk5Wx7g7SRaT20LkXckj+0PNHBWCXROEqdmgTA8KUaJ8ySN/FvVunEMvYBw=
X-Received: by 2002:a25:8d92:0:b0:656:a73e:a7f with SMTP id
 o18-20020a258d92000000b00656a73e0a7fmr1574878ybl.382.1653510975867; Wed, 25
 May 2022 13:36:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6403:b0:17b:2ce3:1329 with HTTP; Wed, 25 May 2022
 13:36:15 -0700 (PDT)
In-Reply-To: <YoT94NOAVt9V43Y7@zx2c4.com>
References: <20220501192740.203963477@linutronix.de> <YnKeag3Ulg0NR58Q@zx2c4.com>
 <YoRFjTIzMYZu8Hq8@zx2c4.com> <87fsl7j8bh.ffs@tglx> <YoT94NOAVt9V43Y7@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 25 May 2022 22:36:15 +0200
X-Gmail-Original-Message-ID: <CAHmME9pnsEUSNJFBnS8ey2ayxhQ7QsO5wAnq3J2Fdg+v1aw9DA@mail.gmail.com>
Message-ID: <CAHmME9pnsEUSNJFBnS8ey2ayxhQ7QsO5wAnq3J2Fdg+v1aw9DA@mail.gmail.com>
Subject: Re: [patch 0/3] x86/fpu: Prevent FPU state corruption
To:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

An update on the VirtualBox thing (not that anybody here actually
cares, but at least I've been nerd sniped):

It looks like they've got a patch out now for it:
https://www.virtualbox.org/attachment/ticket/20914/vbox-linux-5.18.patch
It seems like they call kernel_fpu_begin() before loading guest fpu
regs, but then immediately re-enable preemption. Yikes. So if another
kernel task preempts that one and uses the fpu... And it makes me
wonder the extent of this breakage prior (maybe not just hardirq?
unsure.). Also, it apparently is only enabled for 5.18, so that
doesn't help with old kernels. Oh well. All that development happens
behind closed doors so probably not worth losing sleep over.

Anyway, from a kernel perspective, there's now no urgency for us to do
anything about this. VirtualBox won't compile for 5.18 without that
patch, and given that Oracle fixed it, it doesn't appear to be our
bug. Case closed. So if we go ahead with removing hardirq fpu support,
it won't be due to this but for other motivations.

Jason
