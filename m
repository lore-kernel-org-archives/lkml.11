Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD50C25B08
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 03:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbiHRDGs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 23:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiHRDGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:06:39 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD674D17D;
        Wed, 17 Aug 2022 20:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=iRZ/PGFLncPO09lMuMYQgZDMF8z9twnAkF8pQgS8UP8=; b=NnnshcNvZaIS7Ec8BaxkQ9vLga
        ZNfz6WL/399RYStiP/wsh1NITJjBXzbhkMh6i7sJdKy9kzl21nc5x19u3Al1TRK6WFzKco/8/S9KB
        947tTX24LoodGOD6f2tAf7Svbyeblxks+a6OsKBQWs5vsmzt7P9noz01djtyhaiUJ2TlnXcAKBk+q
        bfCixVWsM19Arw8MJTWvfsUs2edBHGEh9MwWN+8GzXb1YL/OEJ1+bqqMWbFajxpyF3YkCajtPfHqA
        7WBs26y2eeYCjdfXgGWpEiyenFXT2TziZA9YW4X3wcSGtBb/tPVtDhR7giIdGOAT4mBJCplmjaLj8
        2D/tmImw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOVrg-005ams-RZ;
        Thu, 18 Aug 2022 03:06:36 +0000
Date:   Thu, 18 Aug 2022 04:06:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCHES] d_path-related stuff
Message-ID: <Yv2svMjjnMVrHwo0@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Patches in vfs.git #work.d_path (and just posted
to fsdevel); assorted d_path-related stuff that had fallen
through the cracks last cycle (or several).  Posted this
time around, will go into -next if nobody screams...
      dynamic_dname(): drop unused dentry argument
      ksmbd: don't open-code file_path()
      ->getprocattr(): attribute name is const char *, TYVM...
      ksmbd: don't open-code %pf
      d_path.c: typo fix...
