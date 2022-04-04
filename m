Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A11BC433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 21:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352050AbiDDVnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380381AbiDDTxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:53:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED45F4B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:51:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l26so5892418ejx.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lFAH71l5hLiHoLrZZzcQ02KILOzB/xZrhEV5P4Wdld0=;
        b=Qtgc6aj81PF27HwqIjmLraR6kbD2g1Edk4JH8jLfIYET3iNb8qoEFoYXBH7BjQQ4GM
         8tI8gHZon9drp8BlL8xeRuAcE5a116BvXuPVakbHx/K7tjVwbPt2Iv0EgfnkErFL7ZKb
         GNPkfF0lafnWM+sKawmBrReiH9Tf1xoDFXKhOshkxy3PvO+49x7jxaf+NtrpcqbqDN0u
         HF9O5wopaviUM8YsGqJWOON5RVGwN4Hc+4xtI+iR3JwhkL3kDBu86Vv5xOpzCU2D+Oi6
         xN8IfSCARpRBNSNax9wqlfP4rVBgL6u1JtzjiRUMQAoOcFfi1RpuPbk7nXbPj+R2zLB6
         Z+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lFAH71l5hLiHoLrZZzcQ02KILOzB/xZrhEV5P4Wdld0=;
        b=zncB0SiOGMZcAD52GBExE0JGdDLSalPhLNluvAONZrqQgQlY/rH8lYvr10H/LxcCiA
         Zy4QYPl0pfPjyowwtvoI6BKKu2+GfCirfBfpWtxUrXa+KpVck6lpW/xne24iIJRTWtY+
         BGu/4RENTKr0oJV6+LcVpPlMUy49u0AkN0uCVwMTfni7Hv+PatgN/DyhZO3ZPyjx+G9g
         Gy/BJiBjDkXS23vBYaalvn8zAqrbRlqoUU7/6oV6qNpImvbfp7jI0hp33m4PcR2Y/PYT
         yHf02Q9sbCA1Ye5ubbiQpuUps/DqvUaB54QPsb1Y4twltAWICWs7Q0Rsl+P6ylgNS7xv
         K2dw==
X-Gm-Message-State: AOAM533KLVKWePvflubTM22jb5lOcxhTAPvHCHr2QakCM/liJPsMx1wv
        i7mvNMBMEVUbWpn7i6Jx7FtoHxZyA7kL1W05SOTr
X-Google-Smtp-Source: ABdhPJzZaJUJ9iytdCtow0Lr48mbggrWmuIS5YY0v6kb4vhoY/DawljwRSvPi9PvR8qF8W/yV7rYMKSCXNkibAXEfJE=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr1720054ejb.517.1649101889842; Mon, 04
 Apr 2022 12:51:29 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 15:51:19 -0400
Message-ID: <CAHC9VhT2fgrZ5Kcv=-xizUnv0kpr0x+v827YsHYGfos88LjkcQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: Remove redundant assignments
To:     michalorzel.eng@gmail.com
Cc:     Eric Paris <eparis@parisplace.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason this patch never hit my inbox, despite all the other
patches in this series arriving ... who knows ... ?

Regardless, it looks good to me so I've just merged it into
selinux/next, thanks!

-- 
paul-moore.com
