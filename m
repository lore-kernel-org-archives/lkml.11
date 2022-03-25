Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EB0C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 10:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358879AbiCYKdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbiCYKdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:33:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B60C55A6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648204323;
        bh=ZtOinC6kPwWhMbUj1pIOG1a6atFfiu8xYJIpJ0ZvURw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=N7dRmRqsj7ued12KppQsmVuSFdLNiYfUUCVWeSJxM7SyAEnRT8kSZBuFc4VcxL+U8
         Nq4jPWYPmI2SZfsCr6NUsu2Yc69y7XOjqQuHjhBfwFlcfSjxEK51uVEYpyFeNsu0d/
         JY093DowXjUxZN120ihchLylyE6YHmWjTlz0uanE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.67]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAci-1o4Y5D2SLI-00bZsJ; Fri, 25
 Mar 2022 11:32:03 +0100
Message-ID: <969a2030a492f3cecdb7d0095478f1b779c643c3.camel@gmx.de>
Subject: new ltp memcg gripe bisects to b67bf49ce7aa ("post mm/munlock:
 delete FOLL_MLOCK and FOLL_POPULATE")
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Hugh Dickins <hughd@google.com>
Date:   Fri, 25 Mar 2022 11:32:03 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9D3CVVY07d/tYBi8GZqn5whWluU5/wO7M60PC6sQaW9zNBb7soC
 aFb8IYKIN27qH8QqytLDn2jdocGdYJyT4zdxIjsK+vDYLMpzo83OTCglpdhytMMKRkECY0f
 YXj6hzqkp1ODcYyjfJWU5n0SMwBrWeeUJBZ9xaPGHLVekMY3Lm4Aqw22rgmFkWP8sxU7CEQ
 I+z4L7sPfywXh7+eEKSeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uBijktDhuw0=:lhCWFWMUSZc673aN3Ax2i6
 I2y/mlgLyka0ntj+pOntRBGg5RljOvoUc3p+O9jVgJCDJ3IcCvISDfzGfkVQVIS0SlKdGJlzQ
 zzCTdLLluPp+YbQhrDGvMhvv54kBAo0tkEV961VuS2MFzfI9xKYs4zjeIL/zgg+4xH4tDP0Va
 7uYiAlN8xYZ5neaZKZ/iGLazG0ilIDkpjWuHMaRCCWpVLhaxRtEVrIWJXBZOcG9IfXc2R5C18
 I8MAc1gikxsJKzLpDBh4eM70DbQIFfVBUlVzcTnkQVhPpL7iqJ4x5II1i6IeWwxys4hgcnhcN
 mOI+FDTXQXrzzt+P9Xto3YO5SYctNHnoLW7YBhwlZcMF71E8tmAXU7Udz1eHZ7q1EjWnnO7z/
 u4EJI859IfZU1mc2grMji6nIxj4C95qWS7qqw376YBu3BEtx1kyMRLwrtAdOZIHZdwki/3SIL
 GGE4ZCTYCOLJlO757CceX+tGcTVYdGo1R0hpvi8QxtaEHdCCtNN+S9SDHSCnMmY+SsI0MtW2q
 YtdZ8P3/SCTkVr1ztykJtmbxnnYd5GpelSUoKYQC0RXoTov5UTWK0y1ktouztYNFX9FnS7HTS
 ATE9FVVXdXSme3fFkKrj3pOgo4W2vs5v0WLFf+GYOyAFiOZAY21pfQmGAuh9EMLhvbdXZAOpl
 Ng7HbVygd8xhzK6L56C4QcEwtrwUCrYbRyHtZ6c4ihgRR5geyQmxSNMI1NvtUUUKDZqdYTfbY
 xbzbQ8DUTsRIMicv62fHzn2oYgUUC0EC4/7qVoulWX/Z/R9CoYNcBVCHj//6zbl+rp3dVMjGK
 pWtuXo63GhX+dcQwHnRaUgvV7RK+i99cfc5xRGYeHCfzeIG+Kxrlr/Zpq0yRpvYD2Pbe6AIFB
 Reiz+eOhR17jFfeQ0TPyz87ppCAR9KGPsHwOZw3vuUeFcxHUNAV3Ea+Z33zGn6+0iJRGS3Nv5
 fJ70HxUiUXriIST52kepS/dmKmgKJJlVWkBbELJy43lH/mQQXEfuRTHORM5w82JJfPgXIoOK4
 1ZoioILogoPrpk5LpKJ/oLJX1RsdAnPYx5J9G8/DWWMysSrzyrs204Hf+2qav8Bz0WIlm87EP
 5pIIXFjHKMLtuI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

$subject bisected in a kvm ala:

leap153:/usr/local/ltp # cat testme
export PATH=$PATH:`pwd`/testcases/bin
memcg_stat_test.sh
leap153:/usr/local/ltp # . ./testme

Usually leads to...
memcg_stat_test 3 TINFO: Test unevictable with MAP_LOCKED
memcg_stat_test 3 TINFO: Running memcg_process --mmap-lock1 -s 135168
memcg_stat_test 3 TINFO: Warming up pid: 3460
memcg_stat_test 3 TINFO: Process is still here after warm up: 3460
memcg_stat_test 3 TFAIL: unevictable is 122880, 135168 expected
...but may lead to...
memcg_stat_test 4 TINFO: Test unevictable with mlock
memcg_stat_test 4 TINFO: Running memcg_process --mmap-lock2 -s 135168
memcg_stat_test 4 TINFO: Warming up pid: 4271
memcg_stat_test 4 TINFO: Process is still here after warm up: 4271
memcg_stat_test 4 TFAIL: unevictable is 122880, 135168 expected
...or both.  A wee bit flaky.

I wanted to verify with a revert on top of 85c7000fda00, but while the
revert patch applied, the result didn't boot.  Config is full distro.

	-Mike
