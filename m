Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228FBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 13:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiGLNbh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiGLNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:31:34 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E66B6294
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:31:32 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m16so10093490edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hPJjqua15ah0sn3T7jWS+IFyxkya2Msc4Z32Nn2kGoc=;
        b=rg5QfwIufOpJub8XP1Do/yDFjwLo/4t6z3t0MVStmetmWBYwLZdVZFAfcHoRgYuULQ
         dhca7EmYKW/nyw6Emq5yMl47pmsCvL5eqqRyQjI6t+cTZL46Rqp67OGPqy7T1nBYdMAc
         EjhvJ817SyhMg+YYsqMuMFZA3gyJyQl0gJC3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hPJjqua15ah0sn3T7jWS+IFyxkya2Msc4Z32Nn2kGoc=;
        b=UeMs5y9ghnfoAOugICFIVJ2n0cwb1rvbrKmmGBMgl6p9LEUbqLVMNz9l0YiF1cpXSa
         iTbge4VhX0r1NFc33ycV3UGu3OGT/AHVRZXlU82MNmTjqg6sWyeBCbaq57nqdACX9dD/
         trh3dumJWjE8NHgeSOWl7DjgXNDjg6x710VFL0xEPvMMqFHPTFwP+Sf0VncHufoJ3Zp7
         mqJeEMMglZPumgmKzXYtxyCrA7Wzj6UdW9VRp095vFxcdZONXuw8qlApbAxf9rqk3ajY
         ujoQBRGYsS0PDWlcN0fMStLLvSNAaNArDRxb3EVpRBWIKLLIffMwWjbqyY4+QWbeHEUc
         r2SA==
X-Gm-Message-State: AJIora9zzkyo+xiG8ihRYEaglSVwiQsPqGjJUIszYXweMlOepPAVszKL
        IQbAqNbW6bqqZt9JJKDhmKSTIQ==
X-Google-Smtp-Source: AGRyM1usO+07EFR5sCIZbvQcc/IsObDEBI0KLY3SELHUhBKsdOKF7QwU9BBoz3qsp+Ku7g593e0m5A==
X-Received: by 2002:a05:6402:5201:b0:43a:d797:b9c with SMTP id s1-20020a056402520100b0043ad7970b9cmr13125486edd.343.1657632690892;
        Tue, 12 Jul 2022 06:31:30 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (82-144-177-44.pool.digikabel.hu. [82.144.177.44])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709063d3200b0072af3c59354sm3850822ejf.146.2022.07.12.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:31:30 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:31:24 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.19-rc7
Message-ID: <Ys13gTA+irEuI+OA@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.19-rc7

Add a temporary fix for posix acls on idmapped mounts introduced in this
cycle.  Proper fix will be added in the next cycle.

Thanks,
Miklos

---
Christian Brauner (1):
      ovl: turn of SB_POSIXACL with idmapped layers temporarily

---
 Documentation/filesystems/overlayfs.rst |  4 ++++
 fs/overlayfs/super.c                    | 25 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)
