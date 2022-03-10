Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 08:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbiCJIJE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiCJIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:09:02 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D83613395B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:08:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hw13so9864862ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgU1YiosBtNsX8vphzejZ6JG2mH1MwmM6we31LMy0vU=;
        b=XLRUu4GLZhPreZ806DmRXf99JDmVKiWPeD1LAmNi7iFs6z59L9i4F/jRJrJzqAuARi
         YAmhAmHeyyGhZBCOKFVLcVeIEULX25XpOtWyaOv66sQiLWnG03dQqvp6x10xSzfMN31O
         +/KwWBXJfLYujoJ8RwtBipptXGR7a+5ojbcQ2nXwtJA0WLUC9YEVbJ/tyizIz3MPYhRL
         /FMfBvFlNFGA8ztjCHVRzSwYlGlWTQatA7xT0yVR8mVHOnHBKTJ7GqntDNZXtfxfmT99
         VRwDwzUKVLKrTIHdhlsq0P/caDi8xYsldEGJKFEwrYgVGk82TH18IxXM9pMzHhbS8zXW
         U7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgU1YiosBtNsX8vphzejZ6JG2mH1MwmM6we31LMy0vU=;
        b=J88cjtNWWStyiFv0bD/QCbbusahRqnz2gCYun8AG+O1pWBrDVs3DeDYgnCQwMIowr5
         EM6FUxHSJM3aW/vkvlQ8mWVPuRe4Qq7ibQXhnfMxgDrRvjewujD7HxyVNXT/vA+uiQuV
         jxDTdkjK2B/OJ+peTcT24D4NCqp0qS7eS3cbZWlhgRc/TcNX82/shPLAzWTzTmpx1U8S
         ko/A5BXqG+jPzH7oNBi0kveLpJ1iHg7Jpm4RKUtas4h/LP34Y6ykKdIlBXLXHy5Wl+lz
         Hdroi9c2Kg5jR4kQ2seKH5ueQvYky7zUCnrwLlhfmWCRgrp72tMgfkFt81pHMA7JwRpo
         4BZw==
X-Gm-Message-State: AOAM532V470k3VQKkKIlBVz5Bp8aCRcJDDRTKR0BCEdD59x20uVlDFpV
        aYJg+jmOKfLO9gIgh0ti3EVhanUtBwB48hpM37exJA==
X-Google-Smtp-Source: ABdhPJyk8Rd7RVAixssO/1MkmMF/h7pn5Vdo7uxGHhPCpqNsEQqkq7TGhVTpdF1GQhCClhgrzKqe7Q7gtj9jsduNMHU=
X-Received: by 2002:a17:906:2899:b0:6d6:e479:1fe2 with SMTP id
 o25-20020a170906289900b006d6e4791fe2mr3149308ejd.394.1646899680427; Thu, 10
 Mar 2022 00:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20220309083753.1561921-1-liupeng256@huawei.com>
In-Reply-To: <20220309083753.1561921-1-liupeng256@huawei.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 10 Mar 2022 03:07:48 -0500
Message-ID: <CAFd5g457_aWs2mbiD0Eq6Tz=8dpjJD9nHa+iK-RTe8H6kXwT=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] kunit: fix a UAF bug and do some optimization
To:     Peng Liu <liupeng256@huawei.com>
Cc:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 3:19 AM 'Peng Liu' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> This series is to fix UAF when running kfence test case test_gfpzero,
> which is time costly. This UAF bug can be easily triggered by setting
> CONFIG_KFENCE_NUM_OBJECTS = 65535. Furthermore, some optimization for
> kunit tests has been done.

I was able to reproduce the error you described and can confirm that I
didn't see the UAF after applying your patches.

Tested-by: Brendan Higgins <brendanhiggins@google.com>
