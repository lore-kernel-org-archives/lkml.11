Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB723C4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 12:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391184AbiBGL6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385472AbiBGLby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:31:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139F2C02B671;
        Mon,  7 Feb 2022 03:30:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BDFF60AB0;
        Mon,  7 Feb 2022 11:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6103FC004E1;
        Mon,  7 Feb 2022 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644233427;
        bh=A1rMhRx1IR6nDl1kC20YzOonK0OAz8N4dIY/i/zc29s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1MrCR0qp/J/w0ZGpB8yeAmPe+MYTNmhdK/BG87/s+8CPQT4lYLv8rLb/+K/Kyakj
         UGDkcyi8sVuUg47p1pseoUNrg69rAvkVl4800iAT4z29OVk+/06nN5EA411ok1W0LI
         02akeL7wxdrJ5x35DDxv5uaY27y/tiQxC8+OPe5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>
Subject: [PATCH 5.16 001/126] drm/i915: Disable DSB usage for now
Date:   Mon,  7 Feb 2022 12:05:32 +0100
Message-Id: <20220207103804.104537478@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207103804.053675072@linuxfoundation.org>
References: <20220207103804.053675072@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 99510e1afb4863a225207146bd988064c5fd0629 upstream.

Turns out the DSB has trouble correctly loading the gamma LUT.
>From a cursory look maybe like some entries do not load
properly, or they get loaded with some gibberish. Unfortunately
our current kms_color/etc. tests do not seem to catch this.

I had a brief look at the generated DSB batch and it looked
correct. Tried a few quick tricks like writing the index
register twice/etc. but didn't see any improvement.
Also tried switching to the 10bit gamma mode in case
there is yet another issue with the multi-segment mode, but
even the 10bit mode was showing issues.

Switching to mmio fixes all of it. I suppose one theory is that
maybe the DSB bangs on the LUT too quickly and it can't keep up
and instead some data either gets dropped or corrupted. To confirm
that someone should try to slow down the DSB's progress a bit.
Another thought was that maybe the LUT has crappy dual porting
and you get contention if you try to load it during active
scanout. But why then would the mmio path work, unless it's
just sufficiently slow?

Whatever the case, this is currently busted so let's disable
it until we get to the root of the problem.

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/3916
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20211014181856.17581-2-ville.syrjala@linux.intel.com
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -866,7 +866,7 @@ static const struct intel_device_info js
 	TGL_CURSOR_OFFSETS, \
 	.has_global_mocs = 1, \
 	.has_pxp = 1, \
-	.display.has_dsb = 1
+	.display.has_dsb = 0 /* FIXME: LUT load is broken with DSB */
 
 static const struct intel_device_info tgl_info = {
 	GEN12_FEATURES,


