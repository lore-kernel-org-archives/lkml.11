Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6ADC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiBOFbj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:31:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiBOFa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EADC128DC8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6N1Ss1z4y3m;
        Tue, 15 Feb 2022 16:30:20 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     rdunlap@infradead.org, paulus@samba.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210320213932.22697-1-unixbhaskar@gmail.com>
References: <20210320213932.22697-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] powerpc: epapr: A typo fix
Message-Id: <164490279633.270256.14303800612164733087.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:36 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2021 03:09:32 +0530, Bhaskar Chowdhury wrote:
> s/parmeters/parameters/
> 
> 

Applied to powerpc/next.

[1/1] powerpc: epapr: A typo fix
      https://git.kernel.org/powerpc/c/a1c414093370ed50e5b952d96d4ae775c7a18420

cheers
