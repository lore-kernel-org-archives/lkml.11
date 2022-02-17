Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C15C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 18:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbiBQS1I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 13:27:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244431AbiBQS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:26:59 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203737654
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:26:45 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s16so5709229pgs.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=VK2nux5RHN6KMN8bSVV8IsO2fMmx1fTQS8HPOBSHkY4=;
        b=BIGYjILdasy5CZOwOqXMMFIvAgSVOMFlSCUzTzn3XXd2zNZOhPTgezNICCDJn/mLox
         nwCRFHWXCyUjVuZPE3P2WeABcdBE6aJoNJmpc04gVb5q5f9bUOuwNTq6NvSEQYpv82Xd
         7GDS+F74Rg+6pAeMGKALjIQgVJU8/u4Oc/S0Yy7tdPGkQUda4gDKOiDxFQeEGxpNP2u2
         JoZSPWRpoItrMpPgK6DOzopVGz06OY0L1rDSsKUgP1bByz5V7SDJHYBxNIhxjsTdQJKL
         cOm6nYr8dusJb0rOLoGCMbFpn8U8E3SYLHOHfPkNhvGmOSm64U/YR9YZZAVgHXXjWA57
         +Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=VK2nux5RHN6KMN8bSVV8IsO2fMmx1fTQS8HPOBSHkY4=;
        b=73oBE8Ky64y4AAkj5lYqX7bU2RUvbZjPz0bTd9F6/ekbh66JYxdaZmzQqsLiqdsXPd
         NoZaCjcKBLcSSyQ6j66Rc0pqspl2YSjmrLqM1miWWVOQ7qzVDMv2G1nPoO7VMhgr3PiL
         kJkAKgnGYlDn8l14ZMjnwODdrhi2HA3o5lZhO+MsEH05LZIkf6ah7kIOaIgS/ij9R/pR
         2oWaomgP5+b8DuJxHuXf11PKX3Q0V2r/iBx6Lwv/iNP+smszRtb070K28AFH1Ig8TmzR
         bIZt5EKnOku1IJ1Ca3++1ij3DQXTyLoEegr0cH2k5JhcX/CIe//OnkUGZ8YIKlaKXLiC
         ShoQ==
X-Gm-Message-State: AOAM531/FmTCn3xJlraYFDWp68vJb/pUzZg6D+KsQy/1pua/BVR+5Utu
        qjXXcNLXu256hw1/c0piTc9Ppg==
X-Google-Smtp-Source: ABdhPJwXkDOnudXbBSGA1AI0tuNuA6r1jXTyTft9DcM/kqXMorSbh3So1ORECxLoqeVhp1nhusbJOw==
X-Received: by 2002:a63:d47:0:b0:373:598c:e0aa with SMTP id 7-20020a630d47000000b00373598ce0aamr3385706pgn.243.1645122404388;
        Thu, 17 Feb 2022 10:26:44 -0800 (PST)
Received: from [2620:15c:29:204:d97c:650c:cf98:ec43] ([2620:15c:29:204:d97c:650c:cf98:ec43])
        by smtp.gmail.com with ESMTPSA id s11sm333587pfk.8.2022.02.17.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:26:43 -0800 (PST)
Date:   Thu, 17 Feb 2022 10:26:43 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slob: make kmem_cache_boot static
In-Reply-To: <20220217085842.29032-1-linmiaohe@huawei.com>
Message-ID: <ecf778b5-31a1-f99a-9c68-2986379f72b7@google.com>
References: <20220217085842.29032-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022, Miaohe Lin wrote:

> kmem_cache_boot is never accessed outside slob.c. Make it static.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: David Rientjes <rientjes@google.com>
