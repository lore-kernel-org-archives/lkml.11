Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF5EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 20:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiBGUsF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 15:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241934AbiBGUcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:32:10 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6DAC0401E1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 12:32:09 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a8so15009499pfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 12:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1P8hA1j9aywFJgfHjGYLfcilDGyQWP/oEP/rL7ICpyg=;
        b=C06fimZteiDPoqZEu2rPd0hp5X05Xu0F8lNukNvXrC+SHmbeaRXXVOOPeN18tKtywR
         P1+CY4LIGJR3E4i+nMbWJgjXQLn0rgLLAbMXyEDV7jWHBD66bf1bRgmGfwSbPpsJCu//
         FFlgWppTLm/5QqkvSGU/tM/Y1y30kZ6w/e+cqsczks/n8G2VRUX/Yr/7QKsOHOcJLe9F
         WOO+bGwKVmf4WWCoOSQ7ilLPzkYbMmeyT0lNJONAGNKITT6/PApHfzpuqUHjixPw373F
         9/1MDyR0oQawyfmi+5YY2P/IDWOb6kQsvefxAMaUCqC4FSpSOwFSgQ2flSnipZz5F+Rb
         MRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1P8hA1j9aywFJgfHjGYLfcilDGyQWP/oEP/rL7ICpyg=;
        b=5AJIW+uPigHBADkMBFcLaXAxgKI1G1+Z+kf6909nM3hloU8e6XRZG3fcmQB/Hg5BQh
         xDNtvlIfCPGKBMna2974hL8Sd/k4H3MW4rfDNYKKJLDwmdgMKe4Dr00uwt16hgJZWCBe
         U9AhqQSUtbHcBABUNEQ2ePtH1ui9B4TE/dFKrHYPUpMPNzU/XEY3a8GTa/umplVN7b/s
         0E9kgmYXxxb5aq74XhRGhtnmFEuobCg78LXkfxana4br6QfM1hEnCi5MzkvRko8wkTYg
         /S7ZdbIaxXuqhzF4FzAFa+u2oZ7VhndqfEEDYyQDpGtDifc8nLyCFfAzepZpEEMPs+TL
         Q0bw==
X-Gm-Message-State: AOAM530IssoFMJDDhzG9ckYu499Ai0BxEHqbWtcvytYaUaZx4UBfSnFg
        ePt4Adl/NmFnX0+856JPfLJwlnmXRvXrix2N6WO7lQ==
X-Google-Smtp-Source: ABdhPJzdiVW/zhtdK0Fc+Zk69XCZxEluVIICSO7cBbOk5Z3lLzYGJkWJ/w2d7cthfjL73eD7SoteD4xaEYUlVPSO2Nw=
X-Received: by 2002:a05:6a00:1508:: with SMTP id q8mr1109927pfu.3.1644265928635;
 Mon, 07 Feb 2022 12:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20220207112043.397074-1-akirakawata1@gmail.com>
In-Reply-To: <20220207112043.397074-1-akirakawata1@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 7 Feb 2022 15:31:57 -0500
Message-ID: <CAFd5g466EGdOvvAp8t1tZDe4ks1XgJpA1Hwouds+9ASjznxhFA@mail.gmail.com>
Subject: Re: [PATCH v1] Documentation: KUnit: Fix usage bug
To:     Akira Kawata <akirakawata1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 6:21 AM Akira Kawata <akirakawata1@gmail.com> wrote:
>
> Fix a bug of kunit documentation.
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205773
>
> : Quoting Steve Pfetsch:
> :
> : kunit documentation is incorrect:
> : https://kunit.dev/third_party/stable_kernel/docs/usage.html
> : struct rectangle *self = container_of(this, struct shape, parent);
> :
> :
> : Shouldn't it be:
> : struct rectangle *self = container_of(this, struct rectangle, parent);
> : ?
>
> Signed-off-by: Akira Kawata <akirakawata1@gmail.com>

Wow. I can't believe we let this go for this long...and even after
doing an *almost* complete rewrite of that page.

Anyway, thanks for fixing this!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
