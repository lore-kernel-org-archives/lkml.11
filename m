Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3040BC25B08
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 18:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbiHOSUD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiHOSSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:18:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DC2AE11;
        Mon, 15 Aug 2022 11:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 325C361290;
        Mon, 15 Aug 2022 18:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309D7C433D7;
        Mon, 15 Aug 2022 18:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660587374;
        bh=s7UlpMwTs1CItbkC0akguoqCNt4uXYEg3xOEljhn0+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IC0o/z95LaSIP1STqzsGp873tB/OQWpw8+P/wwQ+Z/gcNZgO7QL4Ec7ILkrGvBEHh
         DVbUQUeXWyHDjxA+Ld2EgvaFWAHmlviLHX7o6BfEMMe5Fg+GRRmbKm+ZC7uL8AQa+Q
         1qiJnxn48IwvhGRLpkQxx+7B6Wxr0Xcjla7mJFao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH 5.15 066/779] drm/nouveau/acpi: Dont print error when we get -EINPROGRESS from pm_runtime
Date:   Mon, 15 Aug 2022 19:55:10 +0200
Message-Id: <20220815180340.098324985@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180337.130757997@linuxfoundation.org>
References: <20220815180337.130757997@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lyude Paul <lyude@redhat.com>

commit 53c26181950ddc3c8ace3c0939c89e9c4d8deeb9 upstream.

Since this isn't actually a failure.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: David Airlie <airlied@linux.ie>
Fixes: 79e765ad665d ("drm/nouveau/drm/nouveau: Prevent handling ACPI HPD events too early")
Cc: <stable@vger.kernel.org> # v4.19+
Link: https://patchwork.freedesktop.org/patch/msgid/20220714174234.949259-2-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -540,7 +540,7 @@ nouveau_display_acpi_ntfy(struct notifie
 				 * it's own hotplug events.
 				 */
 				pm_runtime_put_autosuspend(drm->dev->dev);
-			} else if (ret == 0) {
+			} else if (ret == 0 || ret == -EINPROGRESS) {
 				/* We've started resuming the GPU already, so
 				 * it will handle scheduling a full reprobe
 				 * itself


