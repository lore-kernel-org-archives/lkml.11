Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23D7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 19:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiBXTTB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiBXTSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:18:53 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF90B7C5C;
        Thu, 24 Feb 2022 11:18:22 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C97C55BF;
        Thu, 24 Feb 2022 19:18:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C97C55BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645730301; bh=QpnPzN1Dxj5KrJrh6AIXHjdoV4hb+s0gFbvHykrXUjE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tIKRxV2dsyOyFzgKkcSQG7pbHkJPcpwJf7rkFH7Rx1SdQCCN9Am7ffK1tBafyrzQL
         qzHSCyw8SAzkd13aMw1eCndK9BqMqUjHpDqWjuvuVUVeeCnmOia6EqFwiRUK5Levgm
         y307809jwHAw7jV3okINSOAAbza5KssNv4/cypg7+T+FHrdmKMsXQxj/+OpV5SflrS
         Gh2g+aAVxnWt3j5iSZYu8UaMAiPzhFxH+KuTzySttNzlhHNEzBGOyyf7vTm5wGaTnF
         +azNYKvN8he5N2gkOUo2o1HMXaYtwogj4Ix0IOdsqlb1ckvr/Bb0jaiKAt2sg0i5EB
         0EcyGoEFHI9ig==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        hanshenghong2019@email.szu.edu.cn, weizhenliang@huawei.com,
        georgi.djakov@linaro.org, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: Re: [PATCH] Documentation/vm/page_owner.rst: fix commends
In-Reply-To: <20220223134104.2663-1-caoyixuan2019@email.szu.edu.cn>
References: <20220223134104.2663-1-caoyixuan2019@email.szu.edu.cn>
Date:   Thu, 24 Feb 2022 12:18:21 -0700
Message-ID: <87h78okr9e.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yixuan Cao <caoyixuan2019@email.szu.edu.cn> writes:

> There are some commends that need to be fixed.
>
> Thanks for Shuah Khan's constructive suggestions.
> The commends have been fixed as follows.
>
> a. So, if you'd like to use it, you need
> to add "page_owner=on" into your boot cmdline.
>
> Here, "into" has been replaced with "to".
>
> b. ...page owner is disabled in runtime due to no
> enabling, boot option, runtime overhead is marginal.
>
> Here, "no" has been replaced with "not".
>
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> ---
>  Documentation/vm/page_owner.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied (with some changelog cleanups), thanks.

jon
