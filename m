Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A45C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 17:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245051AbiBJRLO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:11:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244818AbiBJRLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:11:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9656E6A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:11:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 42543CE25DC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E09C340EF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:11:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Hs78T9oD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644513066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cd1/cBHJEw3CGs3r58oCd7nCDjXO3T2dxtJf0WtP2nw=;
        b=Hs78T9oDSLeIOjx6xKMiBuEsHIRGDmq8RqI9oFk+WCIpF7yzHtF6JRiTSa6nBcK2osw6sd
        rpLnsvhywdHVWfsLtsYulE227kSruKwQHT81NTZWRSq1Zm/1GLBLtk2wf3cSZv6WmZWwnG
        1nJra/ApnS3Q8ZSXETm53Y69+4vgHxY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1d9f4740 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 10 Feb 2022 17:11:06 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id g14so17389845ybs.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:11:05 -0800 (PST)
X-Gm-Message-State: AOAM533+TLODjV9EMcvZfZ4cGP53SEpI7u0qaOGjVz+c7s6olaM2Rcvc
        Xn6tnxLoD2wBBeaHA3BAYL/OwLAiEOSOxp15lt4=
X-Google-Smtp-Source: ABdhPJy4vLOCQczbefDfMT6EcWguNmjbhNiEqEMLZXP9BuEYm8uj6KR52sZw6JI7Bkh0A7qbDQYjMYGrh2xX5vGpnfY=
X-Received: by 2002:a81:c40d:: with SMTP id j13mr8443554ywi.499.1644513064960;
 Thu, 10 Feb 2022 09:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20220210160925.156697-1-Jason@zx2c4.com> <20220210160925.156697-3-Jason@zx2c4.com>
 <YgVDmcG78PVoP4U3@owl.dominikbrodowski.net>
In-Reply-To: <YgVDmcG78PVoP4U3@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Feb 2022 18:10:53 +0100
X-Gmail-Original-Message-ID: <CAHmME9rieCnqNp=n2jOp2z+pS8qo59B0ULWBhRjCHM8awRWMPA@mail.gmail.com>
Message-ID: <CAHmME9rieCnqNp=n2jOp2z+pS8qo59B0ULWBhRjCHM8awRWMPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] random: deobfuscate irq u32/u64 contributions
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 5:57 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Am Thu, Feb 10, 2022 at 05:09:25PM +0100 schrieb Jason A. Donenfeld:
> > In the irq handler, we fill out 16 bytes differently on 32-bit and
> > 64-bit platforms. Whether or not you like that, it is a matter of fact.
> > But it might not be a fact you well realized until now, because the code
> > that loaded the irq info into 4 32-bit words was quite confusing.
> > Instead, this commit makes everything explicit by having separate
> > (compile-time) branches for 32-bit and 64-bit machines. In the process,
> > it exposed a shortcoming in in mix_interrupt_randomness() which we
>
> "in in" -> "in"
>
> > rectify.
>
> Maybe explain the shortcoming in one sentence? I think I spotted it, but...

Will do. v2 incoming.
