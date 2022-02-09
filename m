Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D422AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347645AbiBIENg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346909AbiBIDi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:38:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25961C043182
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:32:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso3953492pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 19:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rVLKnltV9lRSittC1euYQYIfAU8KczpP9bZo3Hkx0cs=;
        b=doNdBMkj4u3OFQ53O4YQOnkbQiVKdbnuz+0ds+U5lrSTl8aipq394zPVeaTRh3f6gu
         glCy62WV1d/OWuTMxARWElvpLNGntWMAtt9GjeQ5zntuXa7k58CFAZGE6QhIWhwWuXAc
         0jZpuNunGPcc4ucZN2LvDxVo+A5fudPmVry2EbTawH4RUu2FcBEVUT+LLSaejk1gSliM
         T+bmMr8gBjOu2XeXQyY0BQLElB4Cz19kfOsn9f4xYpjYgYyB5+L9df3z4oW/FCEc6Ej3
         fpFTNOhMHbXFaY6LW15AptBKohrKi30ZNbhX22cnwCfI2rowDuvugYREXCwOZgMu5WlA
         UjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVLKnltV9lRSittC1euYQYIfAU8KczpP9bZo3Hkx0cs=;
        b=LQefDKmK+0UbjAHChC9KnpeGWnV2pGphti9EmUv3ZcAI6Gvy/oCNGU7JOMnI/hTeEh
         U6dd5hm7qYiOFT9QheRSA22eRNrwEm3tL2RGSbtqHb0QZhKreF+D267GJPFbHJm03J2e
         8Zt8XK0sSE6H2i5QzX9g7gIGJ9O7MiMFmcwe+fmUlcB7jzKxppuKfoF0ycpaAA8XJeMk
         NJnGot1VAoqeCC9uwr7zMH6NlF+hOPuicu170OMndlGd4W0DoYx1STBzAI/y+LmB8Nj8
         tgU6oyTTU4Ct/Q1Nu2UKJTrWLJCftbxJMyQnZ10d7QN3o3foyCfF1rNFTjAnuiF4IUDt
         4DHQ==
X-Gm-Message-State: AOAM530l+TkW8LIvnEQhDDD+DUk3QUbIC+A3+WUEIEfTRSAcOeEIMHGA
        NnQ1YPFe2zU0ek/9wTF62lKQpg==
X-Google-Smtp-Source: ABdhPJyu136qEREMmE5rRWNipgRkEe9Ge2q6U3XP6K8OgIwHFIIVixc/qw93Thct7pyfwXWB1uN3JA==
X-Received: by 2002:a17:90a:ca93:: with SMTP id y19mr1251720pjt.108.1644377542380;
        Tue, 08 Feb 2022 19:32:22 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4b6f:f14d:be50:86a])
        by smtp.gmail.com with ESMTPSA id p4sm822144pgh.53.2022.02.08.19.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:32:21 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:32:19 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 2/4] platform/chrome: cros_ec_typec: Get mux state
 inside configure_mux
Message-ID: <YgM1w1yTd2XkOEAA@google.com>
References: <20220208184721.1697194-1-pmalani@chromium.org>
 <20220208184721.1697194-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208184721.1697194-3-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 06:47:20PM +0000, Prashant Malani wrote:
> Move the function which gets current mux state inside the
> cros_typec_configure_mux() function. It is better to group those
> bits of functionality together, and it makes it easier to move around
> cros_typec_configure_mux() later.
> 
> While we are doing this, also inline the cros_typec_get_mux_info() inside
> of cros_typec_configure_mux().
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
