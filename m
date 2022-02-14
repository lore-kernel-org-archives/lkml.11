Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48348C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 15:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346794AbiBNPr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:47:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiBNPr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:47:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F4B5F8EE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:47:50 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so6834773pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d93RGIuIkTl9ONDR/IGy8CrV/ag/6z//zpqIUQQL/y0=;
        b=L1otDNWJe0kOmrRtRas2iUCpda9gs/Id5nbMu8W9m58q7UGz1kiDnKTGjqE+ejzhXe
         n9RQ8ip6Dc+MWohqYDVtwTcr1CHSyPVtzDH1AejuqiBG22ilRzGHPxfhhoKpNYftQut9
         7YLZgR1wg6njB2/OJLp2nHVgR7FfZ9WvQIOs/rVsCyL1mLLpVjaWj2iu1IfNVvpAKf/i
         z60ZZvJ+gOrNDhE/bTRj21SbFcdbECo8qpMITWJMOrCjhKvzHyeAUDZK41LmLOQ8KvQK
         umMDxV7pbLkcpoNv1i8/smO/aHwPQ1HFDRsFww5zvUmxqeztosN8uBFgbDYoBIx+7fqb
         PPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d93RGIuIkTl9ONDR/IGy8CrV/ag/6z//zpqIUQQL/y0=;
        b=XB9UfYuBRYbhi5W6Ime3fGiMUaUS7KLkUmApLVGr0zdEgL9wqjBv6IyjnwcndoIzVI
         gWdOn3ngOHWtID+f7k1xlInsY+/Lids45aGLfrf/09/p6SgnApxJ9zEk7xZ2vkGNHTAy
         iWWJi8RgOHIX2bGb6Ne81DcIoYDRId31u5lj5FHZ4nwQU/ktNmytPoRrB+Lp/WUv7rDN
         TfCyH/A3kAhwXApYX+LA3F0N4cAZfYp+jyaBXeJieDfY5imc+karqBBEsTliOM0bqmgf
         8rhzD9r5ZyGKF2nnGwLNjyPUY5YFLg8OTHj797CaN3nyMAb3T+yldHR4lvPNyAp4G5GV
         1Xdw==
X-Gm-Message-State: AOAM531NiCWVyRCroJLTqImWxPRonwWaHjBUPcXi2+AWBrIBZxd596Xq
        zFgAJmPn0QOZa0odLy0OH9M=
X-Google-Smtp-Source: ABdhPJxEUsPtmOXfTSXRhxJdt0HrEWuiFoK5z3XdrkLZyWIsjjdbYZ0PYJtdJMnq5CIBED4i+6mb0w==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr1668583pjz.44.1644853669815;
        Mon, 14 Feb 2022 07:47:49 -0800 (PST)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.xiaomi.com ([43.224.245.244])
        by smtp.gmail.com with ESMTPSA id mn7sm14626806pjb.8.2022.02.14.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 07:47:49 -0800 (PST)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     longman@redhat.com, gregkh@linuxfoundation.org
Cc:     dave@stgolabs.net, hdanton@sina.com, linux-kernel@vger.kernel.org,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org
Subject: Re:[PATCH v5] locking/rwsem: Make handoff bit handling more consistent
Date:   Mon, 14 Feb 2022 23:47:41 +0800
Message-Id: <20220214154741.12399-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211116012912.723980-1-longman@redhat.com>
References: <20211116012912.723980-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman, Greg,
This patch has been merged in branch linux-5.16.y.
Can we take it to the linux-5.10.y LTS version?

thanks,
