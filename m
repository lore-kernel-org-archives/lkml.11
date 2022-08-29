Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAEBECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 09:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiH2J1O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 05:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiH2J1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4122A5B789;
        Mon, 29 Aug 2022 02:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D182A60FC0;
        Mon, 29 Aug 2022 09:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82D5C433C1;
        Mon, 29 Aug 2022 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661765229;
        bh=TMZdKKinBB4e5Mv+EZ3T6/8a+leLIdJ1AXVxpTm8a2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i48GZBj3AXpKN0uAzuIRXxAQT/C9n8cu5AWFfw2R9+9NTRk7w6z3razvcyRPFSM4Q
         yMeidvjFFg/uy0g1yvh9XflOORUvjq9rCIVJRuio1hy+mTB+L3IN60Dlz42D0fgCas
         fFWlZM00Ig1Cx/1AoDfIwCb0n3dC+PdwsBPr/B7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.19.5
Date:   Mon, 29 Aug 2022 11:26:58 +0200
Message-Id: <166176521720610@kroah.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <166176521755100@kroah.com>
References: <166176521755100@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 65dc4f93ffdb..1c4f1ecb9348 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 19
-SUBLEVEL = 4
+SUBLEVEL = 5
 EXTRAVERSION =
 NAME = Superb Owl
 
diff --git a/scripts/dummy-tools/dummy-plugin-dir/include/plugin-version.h b/scripts/dummy-tools/dummy-plugin-dir/include/plugin-version.h
new file mode 100644
index 000000000000..e69de29bb2d1
