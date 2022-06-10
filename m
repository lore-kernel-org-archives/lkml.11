Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E41CCA47B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 18:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350350AbiFJSAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 14:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350302AbiFJR7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:59:45 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E811E96E2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:58:55 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-172-246.tukw.qwest.net [174.21.172.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BA5511E4;
        Fri, 10 Jun 2022 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1654883934;
        bh=JH/pPK3PdwaS2Xi7xlDnP8w8T3qfczyZrYubuPeIXyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F31vm3cN8VWrYD94YXmXCD2rJOHdQI7AMXvPNai/AETIs0RCUXE0JZ6Vc5zS2jL1J
         zUnHrOGXYa387T6fgKuMmx+xn8AQaeS+FxyL38CjdKv0n6JvC96XUsjzJV2jnXjo9l
         fT8WYV0wveytgWk2SpXGDFxtQUxV3s9wqUDQtTjk=
Date:   Fri, 10 Jun 2022 10:58:53 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/1] hwmon: (nct6775) Drop duplicate NULL check in
 ->init() and ->exit()
Message-ID: <YqOGXYiS6y19/8Yo@hatter.bewilderbeest.net>
References: <20220610103324.87483-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220610103324.87483-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 03:33:24AM PDT, Andy Shevchenko wrote:
>Since platform_device_unregister() is NULL-aware, we don't need to duplicate
>this check. Remove it and fold the rest of the code.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>---
> drivers/hwmon/nct6775-platform.c | 12 ++++--------
> 1 file changed, 4 insertions(+), 8 deletions(-)
>

Reviewed-by: Zev Weiss <zev@bewilderbeest.net>

