Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58D7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352514AbiBUJrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:47:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350634AbiBUJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:40:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D323C4A3;
        Mon, 21 Feb 2022 01:17:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF2EB608C1;
        Mon, 21 Feb 2022 09:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69B7C340E9;
        Mon, 21 Feb 2022 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435041;
        bh=mYHp2j2kVIa5fz2wvM3QZPJjPf4jO/gaOjFC/WzNFx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fh4v/DDvXlVr6hkhZqzkU2gAzzat5qz6Eo8Lkdt6iMrrIfmc35pHZP58ZQ1qgqKXF
         dlVExVAYCYzWruoWqC153jJ3ftgb4FkFTA4RYxqJ2b5CjNjmPcpnGn2u3Yp+XBY+M1
         rkOUXwSmELiJxptedHXGyRdoylZsBQGnGvZ3KxOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.16 024/227] HID: amd_sfh: Correct the structure field name
Date:   Mon, 21 Feb 2022 09:47:23 +0100
Message-Id: <20220221084935.645213897@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

commit aa0b724a2bf041036e56cbb3b4b3afde7c5e7c9e upstream.

Misinterpreted intr_enable field name. Hence correct the structure
field name accordingly to reflect the functionality.

Fixes: f264481ad614 ("HID: amd_sfh: Extend driver capabilities for multi-generation support")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -49,7 +49,7 @@ union sfh_cmd_base {
 	} s;
 	struct {
 		u32 cmd_id : 4;
-		u32 intr_enable : 1;
+		u32 intr_disable : 1;
 		u32 rsvd1 : 3;
 		u32 length : 7;
 		u32 mem_type : 1;


