Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A98C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Feb 2022 00:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiBSAmY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 19:42:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBSAmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:42:23 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136FC5BD29
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:42:05 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c6so22728526ybk.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CwZG5OSiL15f+G6rvUJIXtH2dTh7e4BJU4j7zus/aY=;
        b=ENY89xQzumriweHPfrRrVHakOotKvBpKTtT3ha27VxSFkYQHa5r9xCHrg0/ybDxExi
         Zxr+HRarR/fYPwA+HaNezgZuSMZcijJLL3tqw+XuPT7Ijlpia7e2iZiUJxGMhqGP4ubG
         FjFdwlT77DpfXHqKV36ZDB5Ao6EMgoIoAFTTyUaQr9i4RVkBhFOTnTWq2W/wwdyxWLGl
         nVR6Mo0J/lz4dsJzO1PN38M5vX+Nt3V9fjIIyg5rVWV3bIaX9kJEDG5HhE2orLWo8vLs
         HgI8V/nvZ/PctVgavzEqviUMv+SN1rmSPJV4UVUe2ifI3p3xXJHDQdWM7K0lJHq+ajGX
         wAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CwZG5OSiL15f+G6rvUJIXtH2dTh7e4BJU4j7zus/aY=;
        b=zrn3gFaGCY23dLkUiSaNDSz0I9a5tscWjNqYY+bmyXXXrpfTzni8TLAorPq80Pnozi
         yR7HIOID1/clKvLu3Ow4Y/bFzgiHzSG2wPDxOtmQ6F+eG2FeEKhk4kjcZboYXZyvf3Re
         T0sjm4SSa8DnyhIpuPe9mdj3vZDfmRHfpnI6hjmvT9OnQ8jp4OVNwqBT1XSdzNBVNQrb
         uqS4irek2PX+E0U7jaLDece0vHELzw8EVBxjlgjinxbI3JiwBMx2tqYAjg6vJC1r/C75
         JurAYGoJK4WxuBxVd6efuv31YTLcf3nqt3MMj5W8Vck2DSDMPMnj/E5UFPafRrlUke+0
         kAiQ==
X-Gm-Message-State: AOAM530pRm6URVfGCTV1MBmZ4fSSdK+M9MYYsmwTLVzCub+1s9uuMdAu
        vGfh3pPBmnk9Ud2Rqvvt/4FGdyGw4zZRggOZMzAuHg==
X-Google-Smtp-Source: ABdhPJy+0VFLmcD8jpe6HX+7SRwl8NX7xoQUFtPkVVqVYCOak4SQyGOMQFV6gTAfnGfSLROA0mejJcBQ8Mm25rm+IM4=
X-Received: by 2002:a25:a50a:0:b0:61d:720e:2748 with SMTP id
 h10-20020a25a50a000000b0061d720e2748mr9611164ybi.492.1645231324355; Fri, 18
 Feb 2022 16:42:04 -0800 (PST)
MIME-Version: 1.0
References: <202202172055.BVOB1ugQ-lkp@intel.com>
In-Reply-To: <202202172055.BVOB1ugQ-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 19 Feb 2022 01:41:53 +0100
Message-ID: <CACRpkdbXDMorX6rSGyamKDRq_2ruEQG-J+N4cqiYedbQVF4dkQ@mail.gmail.com>
Subject: Re: arch/arm/mach-ixp4xx/common-pci.c:143:5: warning: no previous
 prototype for 'ixp4xx_pci_write'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 1:24 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Linus,
>
> FYI, the error/warning still remains.

A pull request is pending to delete this entire file.

Yours,
Linus Walleij
