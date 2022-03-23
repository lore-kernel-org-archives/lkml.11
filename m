Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB14AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 02:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbiCWCD2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 22:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiCWCD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:03:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4ED70058
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:01:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u17so318356pfk.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLZM3xjvzATAsLNs03YNSwUezrjd1ot4WTDVTGm9fDQ=;
        b=dv8LG5HB7JnpRuMkmPhrs0gyUOu+bD49LFu7+b627kBf4rWuNRmgc0rti4WxA21+kK
         7w+itS9ljtKAYOBw3OgXRL9kow/G9BRpWyY3ySYr9hIqYP4Ipps6phxxPjcV+1L4J+bH
         HoiKS8GdIpwyHoTv64BZf+yBbs077mZH0F/6xVHSxEh5Z6G4yni+V5mYbyXrGwtN57qv
         K2x0bV67beRxQRArYeypA+jLNJK1eAfyIZs/KsvJrekBgrLHZBvZCZKRWey5X9jfoFr+
         7dkYG1dTdPbJWQDFFHndc823VsJiOOKfQQmYYi5rOVa4ik0xcgAlEQXAcbgt5OjSy36k
         kaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLZM3xjvzATAsLNs03YNSwUezrjd1ot4WTDVTGm9fDQ=;
        b=3DjNtxfwE4+AtdqQzUwNaG1DRhLwQM6hkNdjVRrU4JyUB5ykuCYPuI6XDjx03sy3SN
         n0nUPTw2YA4l/enui7U1mdUu6GlG9WAUFJK7Hb2bm2pxfUaelw1jj9cZZj1dQPKy9jSB
         lR01bcKs/diavCz7xpBUD27+TChoG9spuK4moZw2omCM/oJsoL1ZPWWDN11aBTPovwJF
         JBDhMsVOyE62OdpFbcHudfw9XS78rvcQhZDGr8mODOT9Kw+QT2+z7WyHRlfWbzxq/09k
         sB9WJfuaynWMhV0ATv/VBJhVr4VRqP3cIpZZOxG2MTIB9iGdDPeZXdCF4wZxgrP0gfdS
         K4+Q==
X-Gm-Message-State: AOAM530lpS0EQO8FwR5EK+V2NDYUkauu4UHXYoaAjb7vi518THG3+HuG
        6OOYI/5TmdFj9jvfHLiSakQjeVHRWAQPNLSVq+k5JQ==
X-Google-Smtp-Source: ABdhPJyKPoJXGMTQ91hx4JC/7ULV6MnIthDq/HGw4oZirD4Bxtkpdyr/bbPYdPdmmWPBmXzOC81czBXmfdFw36HFaJw=
X-Received: by 2002:a63:5c53:0:b0:381:309e:e72c with SMTP id
 n19-20020a635c53000000b00381309ee72cmr24709569pgm.40.1648000916091; Tue, 22
 Mar 2022 19:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220228094938.32153-1-yaozhenguo1@gmail.com>
In-Reply-To: <20220228094938.32153-1-yaozhenguo1@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 22 Mar 2022 19:01:48 -0700
Message-ID: <CAPcyv4i=1BaEMSJsQWrmPx7ycMTVWXB035xmP8Rc2WEr976Y2w@mail.gmail.com>
Subject: Re: [PATCH v1] device-dax: Adding match parameter to select which
 driver to match dax devices
To:     Zhenguo Yao <yaozhenguo1@gmail.com>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>, yaozhenguo@jd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 1:50 AM Zhenguo Yao <yaozhenguo1@gmail.com> wrote:
>
> device_dax driver always match dax devices by default. The other
> drivers only match devices by dax_id. There are situations which
> need kmem drvier match all the dax device at boot time. So
> adding a parameter to support this function.

What are the situations that happen at boot time that can't wait for
initramfs or userspace to move the device assignment?
