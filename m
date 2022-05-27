Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 13:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbiE0NKK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 09:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352275AbiE0NKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:10:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A29122B66
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:10:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 1so4890636ljp.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPCeKo76snNBaZflfILsWsg+w+6SDoLhW+Bf3h1esco=;
        b=EgU6cO2MCsWQ3U9+SJovGeo8nu/gZZvKHrNMSr9tHG2MiwhH5YDSfb21co30HxxWhN
         zq5Yh57eUTtPkztDWsWwlF0SsQHnAgngAv5zFCFeR4Y6xZhSM1FhnEUVbeXQimhHV9V+
         sbDEClhd8iLvrTaMNgNg6mrJMpkuytdKVoRbBa+nomUh4ws3rTg/UxSePZIRIQrJzzl7
         s8dhsMh8M996+hm8mM3eh1AaUK7sBbWANiczyt7XOXvMx5EBkWJ+FgQKI5usj5NCdArS
         0CJLY73+5a2p7wipXrQTpRYqQARNmzgTuzVwf9B19Teu0O3XD/3UBjrMRYWaRF4CArK7
         4Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPCeKo76snNBaZflfILsWsg+w+6SDoLhW+Bf3h1esco=;
        b=w5lmki2cPpO+FpoAYEtROwcUw1L7Oz6DC9z3dSX/RBOnkdnMIAyNFX5YSPFbmvQfLs
         w0iCHNDOUH+H2pWElJ+SDpI1WTvY8sN3lNEf3N7uaKRtxaRd+S6cu6n2OQpVR4lV10ki
         MmuhPIjLPt7ySLWNa+J/WMPYOsYVek/u9dhvjwmmwYB9sLFTqIeQGOyln4VtfTM2C7lB
         CZFqWeQZ2fc/q42bXExGOVfGFVBiNxpOrT8HLP7JOW81Zo/puRWTr+T5IeEAPTRoc+NR
         0dj0uX69BfDCumLZPF2XpA/OgfL3VepC4Qlqr0nLwc6HuVIZkizv2jAWdWAnDXO7FGio
         AcTA==
X-Gm-Message-State: AOAM530AFKwZMKLfkFWqAvemnSoUlADtMnQFrCFQQMYmez64cpHnAnxd
        +cuq1vw925Wi6PZnc2AwJw2evJbCIaxiHiv/x9ZDbQ==
X-Google-Smtp-Source: ABdhPJxa897czqy8wh91rT78lxnjMja10GdJDTyzo0KIWH/laQKH/u7ZOU0aRbn3PuOk2dtYQK5Zcjp9BtTDBKBTBWc=
X-Received: by 2002:a2e:9696:0:b0:253:edca:d93c with SMTP id
 q22-20020a2e9696000000b00253edcad93cmr14234693lji.92.1653657001495; Fri, 27
 May 2022 06:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220525111756.GA15955@axis.com> <20220526010111.755166-1-davidgow@google.com>
 <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
In-Reply-To: <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 15:09:50 +0200
Message-ID: <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 at 15:05, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2022-05-25 at 18:01 -0700, David Gow wrote:
> > From: Patricia Alfonso <trishalfonso@google.com>
> >
> > Make KASAN run on User Mode Linux on x86_64.
>
> FWIW, I just added this to my virtual lab which I use as CI tests, and
> it immediately found a use-after-free bug in mac80211!
>
> I did note (this is more for kasan-dev@) that the "freed by" is fairly
> much useless when using kfree_rcu(), it might be worthwhile to annotate
> that somehow, so the stack trace is recorded by kfree_rcu() already,
> rather than just showing the RCU callback used for that.

KASAN is doing it for several years now, see e.g.:
https://groups.google.com/g/syzkaller-bugs/c/eTW9zom4O2o/m/_v7cOo2RFwAJ
