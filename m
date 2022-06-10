Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8690AC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 16:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349338AbiFJQgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349729AbiFJQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E2B580C7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA24062066
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7803BC34114;
        Fri, 10 Jun 2022 16:35:10 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Alejandro Tafalla <atafalla@dnyon.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] arm64/sysreg: Fix typo in Enum element regex
Date:   Fri, 10 Jun 2022 17:35:07 +0100
Message-Id: <165487890511.2163242.14599970886779991025.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220609204220.12112-1-atafalla@dnyon.com>
References: <20220609204220.12112-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 22:42:18 +0200, Alejandro Tafalla wrote:
> In the awk script, there was a typo with the comparison operator when
> checking if the matched pattern is inside an Enum block.
> This prevented the generation of the whole sysreg-defs.h header.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/sysreg: Fix typo in Enum element regex
      https://git.kernel.org/arm64/c/ce253b8573ce

-- 
Catalin

