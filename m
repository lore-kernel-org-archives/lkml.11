Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3745DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 15:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbiCJPYq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244062AbiCJPXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:23:36 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B365DC;
        Thu, 10 Mar 2022 07:22:33 -0800 (PST)
Received: from Monstersaurus.ksquared.org.uk.beta.tailscale.net (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7E0AA491;
        Thu, 10 Mar 2022 16:22:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646925751;
        bh=f1cZwxY3Sz3yLsut2yWbhLFFNJnpn/cbPONcZc3vM9M=;
        h=From:To:Cc:Subject:Date:From;
        b=MAz8Uo8ZMfT8UYYCHhyBAylyu4XYtKLCwPeeJzgEli2Nrvg8f0N/4msdI8EVmE0ne
         ogL9DanCVjuvWuUD0Agtolgb3TwMWPFNoU4bg6ie3kCGxb2IAHULCtXSJ/b+gB4dRY
         QRX2aBgfcopymVWqhvLtI8b3B+CdkZ4l7xG1HKDg=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v3 0/3] drm/bridge: ti-sn65dsi86: Support non-eDP DisplayPort connectors
Date:   Thu, 10 Mar 2022 15:22:24 +0000
Message-Id: <20220310152227.2122960-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for non eDP connectors on the TI-SN65DSI86 bridge, and
provide IRQ based hotplug detect to identify when the connector is
present.

no-hpd is extended to be the default behaviour for non DisplayPort
connectors.

This series is based upon Sam Ravnborgs and Rob Clarks series [0] to
support DRM_BRIDGE_STATE_OPS and NO_CONNECTOR support on the SN65DSI86,
however some extra modifications have been made on the top of Sam's
series to fix compile breakage and the NO_CONNECTOR support.

A full branch with these changes is available at [1]

[0] https://lore.kernel.org/all/20220206154405.1243333-1-sam@ravnborg.org/
[1] git://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git
    branch: kbingham/drm-misc/next/sn65dsi86/hpd

Kieran Bingham (1):
  drm/bridge: ti-sn65dsi86: Support hotplug detection

Laurent Pinchart (2):
  drm/bridge: ti-sn65dsi86: Support DisplayPort (non-eDP) mode
  drm/bridge: ti-sn65dsi86: Implement bridge connector operations

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 180 +++++++++++++++++++++++---
 1 file changed, 165 insertions(+), 15 deletions(-)

-- 
2.32.0

