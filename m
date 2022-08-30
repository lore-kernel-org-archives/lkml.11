Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E247FECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 23:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiH3XFl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH3XFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:05:39 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D241D11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:05:37 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g16so9621193qkl.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3q+RTaRoDJ/mS6E2OdJGUZUv/ANh5AS0o0Ziht8MEyk=;
        b=PgxTnvTE29KCKVSMRimB72WadJkatYaN9T3nsES8Z9oojD1WTJQEamPUKdaq1Ym4ZD
         NyUTCKpvvAcet2PSsMpf3O1BtqIkpFuG7nrMyIFlreo8CgAOl2oCb6Y9I2vjdcdMk/JR
         662tf3ZT0yOm21sB0rvyCZCLS1g/C93AZJlkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3q+RTaRoDJ/mS6E2OdJGUZUv/ANh5AS0o0Ziht8MEyk=;
        b=UqDNLr+ewm/4NhpSije7aodv17/vvFehsgkOSq2WHBUCqr20YkRqIaNmnpeXxhpf9q
         9Vzrct3Lodu3SZ7OZhipbrxFstafQ4wOzvgU5DrKAd8d+P3+f1Y5NwNRfsB7dkS+Muri
         cinagIoE5219iFMwvWJNjWaDN28vM7giDj6dWmmXWb72o22qtCDzZ9HmUxWahJGDevSC
         InGoQIrHTnO3zVax870W9uP1zOF+88q7RKikPYvEiY65jUHhiipUeYh7iFVLn7RRTF8L
         37HhYOSJzunRjzjONjwdx7CmW91WQnLfAO+Cjj7JTiYZqEc9C4UeeaUqwCpsvYJp4/UW
         EX7Q==
X-Gm-Message-State: ACgBeo0WL2im90SSxNgFxFBKmWF5c2pL89T3RST4Awa/lS6Vnfejevtz
        LU7wvExPgxxpIvY0IfP7ykzA0tUQChXqD1bECnNcmA==
X-Google-Smtp-Source: AA6agR5Cdy05jCjyZers7UuBLDnUBYOzZ0flmb/NVCrmjXIpevYhyeQiLMi8DfapiijfzKnTxqRo7TCVyUg03BwkPsA=
X-Received: by 2002:a37:bd6:0:b0:6ba:f6d1:9619 with SMTP id
 205-20020a370bd6000000b006baf6d19619mr13070687qkl.366.1661900736963; Tue, 30
 Aug 2022 16:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220830225831.2362403-1-swboyd@chromium.org> <20220830225831.2362403-4-swboyd@chromium.org>
In-Reply-To: <20220830225831.2362403-4-swboyd@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 30 Aug 2022 16:05:25 -0700
Message-ID: <CACeCKad+aXZbSmkd6puSrw7XVUvy1pnta4-2-4dhoJo44dzSYQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] platform/chrome: cros_typec_switch: Use
 PTR_ERR_OR_ZERO() to simplify
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
> Use the standard error pointer macro to shorten the code and simplify.
>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Prashant Malani <pmalani@chromium.org>
