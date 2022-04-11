Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3908C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 15:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347669AbiDKPOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243642AbiDKPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:14:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657031530
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:11:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b24so18809042edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3qO0b98B6aae3zjIvsIIDBv+sAwQNljamHHXkkiayc=;
        b=GiVRkpGcMnz/Wpt9j7pz4rjKJzD+F3eNm0D9KAacAo+BNW5yoDAqRTmacoMbduS5a1
         8QyZXp+wpWUcVw698Kp5UH+oACjSANO15i605qH3npEhmAAT+2fbZUxCE4ZdtOfMpKb4
         dc6hwc9Migb5VS/6TGHpchu+F32laNYHApklj4Rc1Fg2+wKjNj8pNFl+5NyA9Vw6mNhM
         NkFPYUxgAlTwbdiP9n/NUYMRs/12ZCu1PWASLqa/995sqMldPnUrIGg6JWZA4lB0Dj6s
         kiPu2fXSfJ1EDQ/6qzQd5HDRkc3v7uUWSd4qUT1/MKwAaoRA+2DORUXqG/FWchDQknwu
         snnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3qO0b98B6aae3zjIvsIIDBv+sAwQNljamHHXkkiayc=;
        b=JKeexLjN3c/Cf2tPfaCAGofGeBMaI5w1HHos3EpCVdRBFnukf31tGhSx9sU2bxiZ1h
         dgoBkkJms/rV5/9uHGatl6rOBmWQDSQIh8KB2W75OHVL42eQvK+4Fhz6i0xGeEzcbSAF
         WryuCjexpGJIVXUzKqe4JjPpO+HsTb3mLRFGefiTjkcIxHT6OUYEWklDXmRI8zgXutjR
         SNn4/3CxgM5E5nXnk5x7E56/hW6+cn1tFXg0FKQVhLkVj5A+/ChEYeEPJ/riy9/hiVil
         +jdp1SXiCEfEK+sBvxpv9PVj4XiGXcU/edOiSq7bv1qwgtE7F1uBaz2gltihnuonoTSQ
         hWQQ==
X-Gm-Message-State: AOAM532ByQHWDhd205ENOImYtIor4RD4Dyxmt3z36vModPPMyK53HzIv
        nUDpFERpFL8UmURO98nEqU4gK320tQFFzQhhdoA=
X-Google-Smtp-Source: ABdhPJykEVDLi3ZkJCSqI6anMzXqe+THc/EqtjJ1PuTNly4Xah6SEqzv6roORGOparvFOZQF0oGTRPLKyAPxZ4+8nn0=
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id
 i23-20020a05640200d700b004130673ba2fmr34135941edu.29.1649689917967; Mon, 11
 Apr 2022 08:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <1649644580-54626-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1649644580-54626-1-git-send-email-wangqing@vivo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Apr 2022 18:07:45 +0300
Message-ID: <CAHp75Vc-frdJSAMxK1YpHwmPa_-0fTpRxq=QObcux3Jt=5+9kw@mail.gmail.com>
Subject: Re: [PATCH] arch_topology: Do not set llc_sibling if llc_id is invalid
To:     Qing Wang <wangqing@vivo.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:10 PM Qing Wang <wangqing@vivo.com> wrote:
>
> From: Wang Qing <wangqing@vivo.com>
>
> When ACPI is not enabled, cpuid_topo->llc_id = cpu_topo->llc_id = -1, which
> will set llc_sibling 0xff(...), this is misleading.

Shouldn't it be a Fixes tag then?

> Don't set llc_sibling(default 0) if we don't know the cache topology.

...

> -               if (cpuid_topo->llc_id == cpu_topo->llc_id) {
> +               if (cpu_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id) {

I'm wondering if more strict check is better here, i.e.

               if (cpu_topo->llc_id >= 0 && cpuid_topo->llc_id ==
cpu_topo->llc_id) {

>                         cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
>                         cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
>                 }

-- 
With Best Regards,
Andy Shevchenko
