Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C072C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 07:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiDPHQA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Apr 2022 03:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPHP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 03:15:58 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2475237C1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:13:25 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ef4a241cc5so93283957b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Or0tvHHQwf3Nlz+XL5HIsMgAFXWCG3oQQR4aKI6sTjw=;
        b=YEKRwDgDmY/5BIj3zdDwE27CNjzIP970kF6P2K2R+1w+8hrdVTWncn6oYbPce7bMIR
         qoW/zhgvwi/2fVsCznSrlwaU3mR8UQ1MywsgDCxfXMPiA+ADPjjlLMfnwsrjbRrNvRM2
         I/OMltDoUESeSFP0wlCm6mKNQ8q0KaAM46nD+3vYTqe8842RYjGjvxqMFQqJ9/NvLO28
         rK+SgNrshmk9ttW0bPwFMFgmLLIy1dqShw+AQNJi8F1K2k1f0uPuwo16b/cnuX+SzaUC
         5XmPw8EC2I8muA4LlhZXsphb7rmUhryQEGX+Vj1CIS2jXBfs1ZLf/B2YTMrhLQIR0ABh
         Fqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Or0tvHHQwf3Nlz+XL5HIsMgAFXWCG3oQQR4aKI6sTjw=;
        b=FCI6fBdkJD1iKvEC9hZZabZRYYSdQl/Mdjh8/wXAlbLQYWh50EnF88efnAOGiKRVJn
         3fgQ5RlSRFrl4LCuAroWHQmK5EM64atU7iio8dBRCi9WLKF0rLmqRXMkLbQg9PPylj2K
         RLPJFO0fu2rA+RLin/pnBwbAGGP/3EXW0sjmyZBbcXQh7tl9FjEEAavaSalj2eDvSgLu
         231XKiLIhuIdu6OjFDBGFQMxiBSpxNSnvFx4228cBuEjGMcCkZ4k0eJWMNOlsJPc6scD
         VuVtTJT5Uds8Zx4qCW7SzH6HiNk4C3/vcc4GvGCCUaj1IlCGVwM2cwtWxZfFmIt94UOc
         pGug==
X-Gm-Message-State: AOAM531OQhn6wXwA9+NbzFt7MSSYVzoZL6QTNaWMp1j9+Hx2Z6ol7cq8
        m75mV6iAPSVh1Ny5gDK/pY2++cvMjHAgqKIknC2uVC81+iH2Jg==
X-Google-Smtp-Source: ABdhPJxsLwIm5vnjhS3J0wx6X720pzH2WR8HbZAJi+1d7Q4/tTL9pEACLjxzEWkA2uQM2csWwiDMi1YGKHYj39+ghpY=
X-Received: by 2002:a81:92c8:0:b0:2eb:ef8e:b3b3 with SMTP id
 j191-20020a8192c8000000b002ebef8eb3b3mr2160187ywg.433.1650093204951; Sat, 16
 Apr 2022 00:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220416061104.481674-1-vvghjk1234@gmail.com>
In-Reply-To: <20220416061104.481674-1-vvghjk1234@gmail.com>
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
Date:   Sat, 16 Apr 2022 16:13:13 +0900
Message-ID: <CAEcHRTrESTtOvL1GbtgqjdmxFH1KR07PBX=etL0fgKsuicReGQ@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: Remove repeated action in calculate_order()
To:     =?UTF-8?B?7JaR7JuQ7ZiB?= <vvghjk1234@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I accidentally sent a wrong version of patch. Please ignore this.

I'll send a correct one as a v2
