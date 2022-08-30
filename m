Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5C0ECAAD4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 23:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiH3XGg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH3XGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:06:33 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C336E9F77B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:06:32 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id q8so9870275qvr.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nBDXZy0PNI6HxH20NIcd0boi0iBLy+daKqm4xUcQcFU=;
        b=h8viMjz+y6iHBxaQsccGgC/gv+qGP1KNSL8rg/v4QcxfEnmZ9wgWx9AJSUgxsgxFJ1
         /2E5OZi80IiFljcLSosBBJxQaTgXYAOU1HzUM/GLORtvZcmDXlNTyp0cfRQQQJdkcxzo
         xgugvXpTk/iTffxwFcSe209orXG7+HVsu4M4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nBDXZy0PNI6HxH20NIcd0boi0iBLy+daKqm4xUcQcFU=;
        b=WewO+vGiCv/093RoLshEkqedV1DjokCFZFV6jzUz/QAWCo8aPLlwI7BNzlLbbedZ71
         1o+nULW65cssOf9u9iuvSeqdLd7IEO7E6bPe+mGm7xSHmF1pABV4kxj6iymEsmiK/RpT
         GNBS+IY1a3RFxDFRFmtV7sEhGjfoSPR+5yecg6uOpDttg5IJNvHqA62g91CD7ry1nIcS
         Nbkik5TZ5im36V0/i/VgYX87+pohjxWPKkYDqe0oHA6XDwkUbUReRZ0s1jir9NRV0Vaz
         7XixAnU6jQmWECvRPpEVvCEkpNGAm8T4vGpyb4o/S/ESjvyXrTA5hBsxt9mZAXRV0G8/
         6ovw==
X-Gm-Message-State: ACgBeo03q06PJ10bjfHa9FWvl/DZk+s5cYLeQ5B8Qb8bPnGh943jQScx
        tkwyQtx//jDlQ4MjtRcbqWWvzUJWjJO9R+EBc766WdvJsqx05Q==
X-Google-Smtp-Source: AA6agR5UHLA8tvZAhQU4iM5tHIJAg9lMspH17o8Q7wO2kO91E24epLxwG8CU0Ojl/5hTeZIy2P8e1YISSNiYUw1f4IA=
X-Received: by 2002:a05:6214:2a82:b0:499:720:509e with SMTP id
 jr2-20020a0562142a8200b004990720509emr8585137qvb.62.1661900791943; Tue, 30
 Aug 2022 16:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220830225831.2362403-1-swboyd@chromium.org> <20220830225831.2362403-5-swboyd@chromium.org>
In-Reply-To: <20220830225831.2362403-5-swboyd@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 30 Aug 2022 16:06:20 -0700
Message-ID: <CACeCKafwySAK0Wti1PC7ZC=OjBoM96XXHMnbtAdyTMrQMz436w@mail.gmail.com>
Subject: Re: [PATCH 4/4] platform/chrome: cros_typec_switch: Inline DRV_NAME
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, chrome-platform@lists.linux.dev,
        Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the cleanups!

On Tue, Aug 30, 2022 at 3:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This macro is only used one place, let's inline it instead to save a
> line or two.
>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Prashant Malani <pmalani@chromium.org>
