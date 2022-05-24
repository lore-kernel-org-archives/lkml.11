Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADE8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 11:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiEXLRH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 07:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiEXLQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:16:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065AE3EA9D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:16:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s852x09z4yTX;
        Tue, 24 May 2022 21:16:05 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, npiggin@gmail.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        haren@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, Zheng Bin <zhengbin13@huawei.com>
Cc:     gaochao49@huawei.com
In-Reply-To: <20220511033507.2745992-1-zhengbin13@huawei.com>
References: <20220511033507.2745992-1-zhengbin13@huawei.com>
Subject: Re: [PATCH -next] powerpc/pseries/vas: Call misc_deregister if sysfs init fails
Message-Id: <165339058660.1718562.17170565423375451543.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 11:35:07 +0800, Zheng Bin wrote:
> Undo effects of misc_register if sysfs init fails after
> misc_register.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/pseries/vas: Call misc_deregister if sysfs init fails
      https://git.kernel.org/powerpc/c/426e5805226358dbe9af233347c5bf3c81f2125c

cheers
