Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A1C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiBOFbH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:31:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiBOFa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CB212865B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6C24lSz4y4Z;
        Tue, 15 Feb 2022 16:30:11 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Corentin Labbe <clabbe@baylibre.com>, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220125135421.4081740-1-clabbe@baylibre.com>
References: <20220125135421.4081740-1-clabbe@baylibre.com>
Subject: Re: [PATCH] macintosh: macio_asic: remove useless cast for driver.name
Message-Id: <164490279336.270256.12209297383271051040.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 13:54:21 +0000, Corentin Labbe wrote:
> pci_driver name is const char pointer, so the cast it not necessary.
> 
> 

Applied to powerpc/next.

[1/1] macintosh: macio_asic: remove useless cast for driver.name
      https://git.kernel.org/powerpc/c/ccafe7c20b7de330d9091a114c9985305759f1ee

cheers
