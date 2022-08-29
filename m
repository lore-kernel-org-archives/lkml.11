Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F6EECAAD8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 21:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiH2VwG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiH2VwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:52:03 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF829E881
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:52:02 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11c5505dba2so12441158fac.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bxfy8Zomwh4A69BNWtvxjiLXRoFPJjf2nnflSlK/Tys=;
        b=RaxnAUlK3ZvWqXQBwZk8akYg196Sn0svypA19wVKdxfe64zdGxlul9eVpCbKGd9ri7
         VSqhmO36X8RG4ic9wbWCovIEjIYfm6tp1i7D6N+h/s5WcjfT0yE0PYt7XZqVzo+cdxT1
         JnOAsrsor/hDNazFDw4U2rrZ3c3NQLJNQt1QrtOCmz2tiFYrUXfD8BYu05KGwEcfxxdY
         NkDI5PUwrC0U9IYuklKNOc/oXXiTbPUW2O87i6LsAz5iF6DF5c1aY8vHemjKjedVgMMZ
         7XrSI4BOqlNrr35yXy9SZcpD3vGn2a6SpNwlMH4QDNGfcW2j72EzAbXW54/ANmtAULeX
         Zd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bxfy8Zomwh4A69BNWtvxjiLXRoFPJjf2nnflSlK/Tys=;
        b=LikQHTetJSKT6azx4piXBXhEyhT1xfDq58EgFQnUS4ivEKeVAiSJobGmW9c3ZOuet/
         XMvMoa1ilBYt91IXfRxkLAbnvc3JJqlEn1zPnPCKRcwiCwgZSsu2V1Fy1kQNsZtt9XUP
         eF1tmtKX5lUNsOqvhZlFUZGk0Punpqir+Q2iX8D6BOm16Yw5Kg+KuzHxnnz/JsxjMMMx
         Hr0oq1JWEjZhkw8QkbEAlZxi12p3sIkqCOAww4XsIdZP+HqU5n68Gqq63XCnsZDEdw+1
         ysN7WaMyqixePFsgtc1RtpfCYJJ3edWI6uMNjElnoifXGHHTRWCuhnqdxprJ66AtWNKA
         pTdQ==
X-Gm-Message-State: ACgBeo0wXVCv1zVdVfj+Wfwyv0Yo803ylhjGAQfDJ/SsQ4HttRFq++hw
        R7orZCqle0WlL4q4HxuJL7a5rYeBs+Zcsmm4AMfKAg==
X-Google-Smtp-Source: AA6agR4Rn7yklbl82D2fQX/X0qmfMsVoZOpAdKpt0McPV8rfEBijYLWU71oEjyLOIaviUeEC/qVCzsR7eAftQxwMkFY=
X-Received: by 2002:a05:6870:e996:b0:11d:6525:791e with SMTP id
 r22-20020a056870e99600b0011d6525791emr8513997oao.175.1661809921628; Mon, 29
 Aug 2022 14:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220504161439.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
 <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com>
In-Reply-To: <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com>
From:   Matthew Garrett <mgarrett@aurora.tech>
Date:   Mon, 29 Aug 2022 14:51:50 -0700
Message-ID: <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
Subject: Re: TPM: hibernate with IMA PCR 10
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
        dlunev@google.com, zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 2:45 PM Ken Goldman <kgold@linux.ibm.com> wrote:
>
> On 5/4/2022 7:20 PM, Evan Green wrote:
> > Enabling the kernel to be able to do encryption and integrity checks on
> > the hibernate image prevents a malicious userspace from escalating to
> > kernel execution via hibernation resume.  [snip]
>
> I have a related question.
>
> When a TPM powers up from hibernation, PCR 10 is reset.  When a
> hibernate image is restored:
>
> 1. Is there a design for how PCR 10 is restored?

I don't see anything that does that at present.

> 2. How are /sys/kernel/security/ima/[pseudofiles] saved and
> restored?

They're part of the running kernel state, so should re-appear without
any special casing. However, in the absence of anything repopulating
PCR 10, they'll no longer match the in-TPM value.
