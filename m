Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E3FC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 07:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbiFUHDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 03:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbiFUHD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:03:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB92205F2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:03:28 -0700 (PDT)
Date:   Tue, 21 Jun 2022 09:03:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655795006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdkDQIhfC7cpssWNBP1piNlmLoHC3/U6At/sRsoe+rU=;
        b=jhGf8KyfIAO2gyDlwFrSoGn6NchTV7CdMre3vRs0CG156iO1wLTmbS793aSUrxnJw6vBx6
        FTa3Y+rBUBpa13zOPdhtbdkiH1vq19F2orvRqGxyQtlqVO7CfdqH2myU5sYy8zR5Ki7iNH
        ULXJmbEPltX76cklds43+MJYFCDoWhOLE2DDTaagIO+7k9b/PSo6yW3EU2M89JGRcmqBBy
        GnU9Nf4HLZFgGFjjp+n2Yvb1+PQlCniD4sxjn1I/dDaHk5oVhSwVUFHf5f+LERkIfrOE1c
        bZTNALDbRsgUtrRN7Y1xnjRh1nR9kX0Rw6h2BDMUJ8r41d6LUhoWa1+s3n+y9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655795006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdkDQIhfC7cpssWNBP1piNlmLoHC3/U6At/sRsoe+rU=;
        b=A2jjLFihl/0JDSGAmgECFehN6v0oif4Novkf0hzP6B73qa17M4A9XI+nTC5R/swdjWNs8R
        mFstRycliQuZpNDA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Fix signal_pending() usage
Message-ID: <YrFtPYItG0+YgR/8@linutronix.de>
References: <20220405163931.1108442-1-jannh@google.com>
 <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
 <YqywapDM7NPC/X+E@linutronix.de>
 <Yq0EcG9GsAkoiF3H@zx2c4.com>
 <YrAlPKeOowD5qv/B@linutronix.de>
 <CAHk-=wg5jqTdjZrwbSsMsd=NUSi_acBHoLQmRDgNArMvXWj8bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg5jqTdjZrwbSsMsd=NUSi_acBHoLQmRDgNArMvXWj8bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-20 14:00:18 [-0500], Linus Torvalds wrote:
>
> As mentioned, expecting an uninterruptible read is not "security". It's garbage.

right.

>               Linus

Sebastian
