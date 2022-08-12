Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B12C25B0F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 02:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiHLCao (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 22:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiHLCai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:30:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9CF47;
        Thu, 11 Aug 2022 19:30:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so7085512pjm.3;
        Thu, 11 Aug 2022 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+xBmFsIMtbl1paHSfTPLrfmLca4uPQjxWRYrS+Srkbs=;
        b=otrgUbjIRk0oD9MaCPUWnY3TYpiAvriMHq68c4sOIbl8TWgSQZeM8FjEkhsB6qaAir
         F5trMoWFlQYtCih81c3mEoLY1UYx9WW4TDFOBoNNq82zGQuniNQ3ksnsYGRs5GECM1Jw
         Z5IVrnkGlicPQsiIDKVL8g0XUuw0vBjO7v9YkfLxqDscxEueoE1UDBk/w6sLtB2+VXop
         Oak3m2I6e4lg6EoE0Ux6LxLsPLLRwQ7RhX3TMX0G1czyD/GiNwQw58KuuaGXYoktrcl/
         nvWCH3Ag/rOxGa37/YYABDsFXbcfHLSGB8yojBpuVF9n63nw1AJBdzfnXNQDZrc8aWVD
         U1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+xBmFsIMtbl1paHSfTPLrfmLca4uPQjxWRYrS+Srkbs=;
        b=Rh9zJcB8tnJSWsYgKVcekCHVHCRaWUWXLhGsDxcr0hIejMuYM7Fp5/X2I/IM+/f9no
         1yjgw62suGfGK3gEVWhU6BbGwoHYPqCu4PG/Ta4zg11pQ/6ehxcaLsVAGT1aEYCs7mau
         dyUEUtqUwbvcKiaocC4PFGvYsf53iVj0UIPv1bINQjsUxZkLCET2wrUE8R1Uht9DT0/Q
         vsJruqxoQFWwJSL4V3Lfv+6ZW33loQ5dG6B+CM2RgXdufBXBoj/GwLaKVF8iuF+U6l/M
         9RIEPnGNEsDJgynOnXDvlmKt/ipRTOhaxN9WEFIwvwNsODRHJBvjGGQ/YA9vsTlv3/Hg
         iNvw==
X-Gm-Message-State: ACgBeo3zbshpZyopHZ6Ylbb3bT19wDUF5z4ft5B4TM0G3QvSdJ+Ilky8
        pdBqWww0GdJ0nXlwdw6WrTZDuX49/4Fw/GOn8cs=
X-Google-Smtp-Source: AA6agR7/t8mrAlGMqHCHFLlg2uL4j8R7cotm92iAvigimvSzv9y8C9mlEKfZC81BNmF1p7VBFDf16pA/7pnT6KBEsFw=
X-Received: by 2002:a17:902:e394:b0:171:3f46:1f13 with SMTP id
 g20-20020a170902e39400b001713f461f13mr1862683ple.174.1660271437143; Thu, 11
 Aug 2022 19:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220811120708.34912-1-imagedong@tencent.com> <CANiq72=Eq1265hYhEVTGuh-_ZW+3HjWkwaktEfs7H7yPERfO0w@mail.gmail.com>
 <CANiq72noui51tmbhySEH1B=cRJm2JgNMGPboLoguZ+P53whRsA@mail.gmail.com>
In-Reply-To: <CANiq72noui51tmbhySEH1B=cRJm2JgNMGPboLoguZ+P53whRsA@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri, 12 Aug 2022 10:30:25 +0800
Message-ID: <CADxym3ZJRe1ZLDZJAuV2zPSwRGjXe1705+=aWsf634AL=bj+4Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skb: prevent the split of
 kfree_skb_reason() by gcc
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     kuba@kernel.org, ojeda@kernel.org, ndesaulniers@google.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        asml.silence@gmail.com, imagedong@tencent.com,
        luiz.von.dentz@intel.com, vasily.averin@linux.dev,
        jk@codeconstruct.com.au, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:35 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Aug 11, 2022 at 4:34 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Two notes on this: please use the double underscore form:
> > `__optimize__` and keep the file sorted (it should go after
> > `__overloadable__`, since we sort by the actual attribute name).
>
> s/after/before
>

Okay......Thanks for your reminds :/

Menglong Dong

> Cheers,
> Miguel
