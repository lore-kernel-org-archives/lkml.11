Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84326C25B08
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Aug 2022 15:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbiHTPFt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Aug 2022 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiHTPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 11:05:46 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD929B1F0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 08:05:43 -0700 (PDT)
Received: from [192.168.0.105] (unknown [136.169.224.60])
        by mail.ispras.ru (Postfix) with ESMTPSA id 90E0540737B7;
        Sat, 20 Aug 2022 15:05:36 +0000 (UTC)
Message-ID: <7d4dd8009a777a7d32f4872dc0285878dbbb91b8.camel@ispras.ru>
Subject: Re: [PATCH] platform/chrome: fix double-free in
 chromeos_laptop_prepare()
From:   Rustam Subkhankulov <subkhankulov@ispras.ru>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Date:   Sat, 20 Aug 2022 20:05:13 +0300
In-Reply-To: <YvnS7IKr/9VhffHX@google.com>
References: <20220813220843.2373004-1-subkhankulov@ispras.ru>
         <YvnS7IKr/9VhffHX@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-15 at 05:00 +0000, Tzung-Bi Shih wrote:
> Alternatively, I would prefer to fix the double-free by setting
> `i2c_peripherals` to NULL after [1].

Since 'cros_laptop->num_i2c_peripherals' is assigned with nonzero value
(otherwise the code on 'err_out' is not executed), setting 
'i2c_peripherals' to NULL after [1] will cause dereferencing of 
NULL pointer in chromeos_laptop_destroy() at [2]. 

[1]:
https://elixir.bootlin.com/linux/v5.19/source/drivers/platform/chrome/chromeos_laptop.c#L787
[2]:
https://elixir.bootlin.com/linux/v5.19/source/drivers/platform/chrome/chromeos_laptop.c#L860

> After a quick glance, I found an invalid memory access at [2] if
> `i2c_peripherals` is NULL (see [3]). 

After applying the patch, there will be no invalid memory access at [2]
if 'i2c_peripherals' is NULL, because in this situation 
'cros_laptop->num_i2c_peripherals' is zero and there is no single 
iteration of the loop.

> Or was the double-free issue
> discovered by
> some static analysis?

Yes, it was discovered by SVACE static analysis tool.
