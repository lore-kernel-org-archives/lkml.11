Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE048ECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 23:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiH3XFK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiH3XFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:05:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A923BCA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:05:01 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x5so9773670qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lGIdeZM1S9hN/ejZ6gUGJwd3xauHVCbCEipm4Vgi8qU=;
        b=dlbf6/F/P4SrgvdTS2+FiE5hANx0T0WOLMIcQSg9PEuqXhJz2+xSo5B9WwxZIUFQQx
         hIKvzmjjmhGf5tzZUJSxB90z3XIIMGNHnbyBSYXudVhDVtzMBcZjWSKlMZ0ENUqHuRPU
         JpbtQrkx3v+o+101M4mqAd20O3M31s7gU8rkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lGIdeZM1S9hN/ejZ6gUGJwd3xauHVCbCEipm4Vgi8qU=;
        b=HH9wjp5UabBse7UHLm26U4vyo2P0TWSlQlMsqjjOMDt7OFyWfkJDoDmPLz8N1yGrYg
         pjXXfeldf7OyWMfV7SpfZcmo3YMiM1nj3DbrcBTbHH0AUHzvH18qfvqYiNVETIpSkpt6
         eVaMbkkLxKMF3Qd6gV5/I8mXszLUkwxx+UEtrG6Bt9hxw397WVBJ34dgnOfzVtfYwb/P
         nhazswQcbu4Bq8s+SU4//XVwBWQ7ldqJPjDsCdha+1O13OJ5nWDfXiobwcpc9EKUJL8t
         6HwGPVvcSU7/pC1HO+ofla4VyMWrVN/sF4vC33kkV5XIr3fGe6HALWc4WcNMvySC2q3D
         IjsA==
X-Gm-Message-State: ACgBeo1nVg8NdTfJc0qGbniEaueqkpVIw1X/o7mXsxo0TtJ/bO3Vg2Th
        kTrcM+gnwgFYieyGBf4R8WMUsuHpDrM05zwe7D+hOfyDopc=
X-Google-Smtp-Source: AA6agR5c0XeQFvIoD/9i1d+eD97rvNFHI5OWnMRuWRK0UMO/zTCiwEeveR9tSFaGf6Y1iLwckZrNLl9LVLaZKLB1Eyg=
X-Received: by 2002:ac8:5ad2:0:b0:344:90e7:410f with SMTP id
 d18-20020ac85ad2000000b0034490e7410fmr17446555qtd.625.1661900700697; Tue, 30
 Aug 2022 16:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220830225831.2362403-1-swboyd@chromium.org> <20220830225831.2362403-2-swboyd@chromium.org>
In-Reply-To: <20220830225831.2362403-2-swboyd@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 30 Aug 2022 16:04:48 -0700
Message-ID: <CACeCKacwLMTdaURq2F5uiE2KcJG0pcMUBR8UZy5ftGZpWZRL=A@mail.gmail.com>
Subject: Re: [PATCH 1/4] platform/chrome: cros_typec_switch: Add missing
 newline on printk
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, chrome-platform@lists.linux.dev,
        Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 3:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We need a newline here to ensure the next printk starts fresh.
>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Fixes: affc804c44c8 ("platform/chrome: cros_typec_switch: Add switch driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Prashant Malani <pmalani@chromium.org>
