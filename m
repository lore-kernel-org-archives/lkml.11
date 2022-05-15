Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D81C433FE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 10:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiEOKOu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiEOKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:14:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045A393D0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:14:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JCC4Hgsz4xZ3;
        Sun, 15 May 2022 20:14:31 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     arnd@arndb.de, alastair@d-silva.org, ajd@linux.ibm.com,
        Hangyu Hua <hbh25y@gmail.com>, mpe@ellerman.id.au,
        gregkh@linuxfoundation.org, fbarrat@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220418085758.38145-1-hbh25y@gmail.com>
References: <20220418085758.38145-1-hbh25y@gmail.com>
Subject: Re: [PATCH] misc: ocxl: fix possible double free in ocxl_file_register_afu
Message-Id: <165260953458.1040779.9899337864192630526.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:12:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 16:57:58 +0800, Hangyu Hua wrote:
> info_release() will be called in device_unregister() when info->dev's
> reference count is 0. So there is no need to call ocxl_afu_put() and
> kfree() again.
> 
> Fix this by adding free_minor() and return to err_unregister error path.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] misc: ocxl: fix possible double free in ocxl_file_register_afu
      https://git.kernel.org/powerpc/c/950cf957fe34d40d63dfa3bf3968210430b6491e

cheers
