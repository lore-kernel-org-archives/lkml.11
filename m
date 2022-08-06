Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E505C19F2D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Aug 2022 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiHFTkS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Aug 2022 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiHFTkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:40:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2042640
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:40:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a89so7071163edf.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tOIk9T3mrJJ6IuQUCBUTAzpxYi7UFUGbDAWnXcWZxT0=;
        b=ePpuRMrAKZw1DYzxtcv62TLH7DJlO326HoiUxhmUAzA0zfgGb9NwLIsmbLIB9w4L4t
         ZXCv3JltfSSLzfVDQ9mawK0U1XXajiwv0n1F9aZrD2MWbobLvwCn2dQOKWhc8634emfq
         xfx/Bf9l0Lc+eo4FmcJeKFU/GH/mTNAF1yLWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tOIk9T3mrJJ6IuQUCBUTAzpxYi7UFUGbDAWnXcWZxT0=;
        b=QYAkZNOpzTfq2wdWjGtnKzAuqxnmk9v9/8WNZ2KctqVsgSK702DFWpxgPsuaESxk6T
         gfWBUFI31NDPh91HPfbgyY0V6AFqOFXjOpWiJECvBrULu3GPGDIvLfavXmV5pgF1AiQd
         ogzTYeF4drI6KwgOrkGQP+JBCN+FGFEsUKow0sdCLGcImQI1Ae32NBzh4Bo0tdDlkd59
         wwgYydPJ26Q6Zkd/bdGVuoU+dO3EdcVAfV1NKMadZZk0CXQVhQaUic8CwCeRsrISB/FF
         MQOEuKiXDaTsYsmF3f973OOTm3eN0tK7optkqY9hPCLlTreIGJthhreDl9GXY3lZy8r4
         GDew==
X-Gm-Message-State: ACgBeo3L06sIPbD2MrIUYUWaA1nR/v5p5gzwx9wYVRbYp68tkNnngt+Y
        kOj0u4c7Afp+6t/Yea52YwH2IAelySOGrIIT
X-Google-Smtp-Source: AA6agR7/+UmZZXcajqdbc7djnchqUdxlr2mQ46xAZqvUUypDTP8qbitXWWIkp8sntzKzxaRDp0QWdA==
X-Received: by 2002:a05:6402:294c:b0:43a:91a9:a691 with SMTP id ed12-20020a056402294c00b0043a91a9a691mr12146844edb.182.1659814811909;
        Sat, 06 Aug 2022 12:40:11 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id g20-20020aa7d1d4000000b0043e8334f762sm1893183edp.65.2022.08.06.12.40.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 12:40:11 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id n4so4892821wrp.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 12:40:11 -0700 (PDT)
X-Received: by 2002:a5d:6dae:0:b0:220:8005:7dff with SMTP id
 u14-20020a5d6dae000000b0022080057dffmr6988390wrs.442.1659814811001; Sat, 06
 Aug 2022 12:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <YuzlAT7RW1U36+ap@8bytes.org>
In-Reply-To: <YuzlAT7RW1U36+ap@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Aug 2022 12:39:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
Message-ID: <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.20
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 2:38 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> IOMMU Updates for Linux v5.20/v6.0:

I'm currently bisecting a boot failure on my desktop, and it's gone
into the iommu code.

I'm assuming it's the 64-bit thing, but I'll bisect further to make sure.

If it is, it will be reverted as hopelessly optimistic.

              Linus
