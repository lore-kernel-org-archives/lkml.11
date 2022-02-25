Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D11FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 16:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbiBYQPR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242705AbiBYQPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:15:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455191A8CB7;
        Fri, 25 Feb 2022 08:14:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBDE3B83278;
        Fri, 25 Feb 2022 16:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A29CC340E7;
        Fri, 25 Feb 2022 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645805670;
        bh=xkC4nSLHICZXNHLPzus0cNfYAdOEoTaFaMgu+1Pf2Vc=;
        h=From:To:Cc:Subject:Date:From;
        b=KWzljE6iP0Y97AxNUAcL/+fpHDJq+enejnltiHRu5mlxaBfZ3P2f5S6vvhYvFMRlZ
         5lx4hDKWtwpPHnv/RCFL47/gTQjHP9l5p9lm97amNS8k1YorS/bndcY1pO8qSbZD27
         UFiumJwdp/SnxZLlsDA3SRUYI+h2rEe27MmIPedORKgyuwW9x4N6PEg9fhNea4ROx3
         HvAAIWTzr+vwekPDlVXPJQpPnFepl/t4ET8jAuvjwj8ePtqN0BG2zVDZf1LMsikXwF
         tN9CjGuTx6eAMomX5NQLgIQ9rOnPti0UqMPV8104E87n5ornDX3kD+RhhdTwuETlth
         QfwWHvwjwubog==
From:   broonie@kernel.org
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: linux-next: manual merge of the drm tree with the drm-intel-fixes tree
Date:   Fri, 25 Feb 2022 16:14:25 +0000
Message-Id: <20220225161425.456356-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_snps_phy.c

between commit:

  28adef861233c ("drm/i915/dg2: Print PHY name properly on calibration error")

from the drm-intel-fixes tree and commits:

  c5274e86da5fe ("drm/i915/snps: convert to drm device based logging")
  84073e568eec7 ("drm/i915/dg2: Print PHY name properly on calibration error")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

[Used drm version]
