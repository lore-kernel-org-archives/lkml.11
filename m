Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0DAECAAA2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 03:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiH2DGO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Aug 2022 23:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiH2DGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:06:11 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEBB714010;
        Sun, 28 Aug 2022 20:06:08 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 874551E80D59;
        Mon, 29 Aug 2022 11:01:28 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L3KFHLehW2WG; Mon, 29 Aug 2022 11:01:26 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: junming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 73C2E1E80D2C;
        Mon, 29 Aug 2022 11:01:25 +0800 (CST)
From:   shijm <junming@nfschina.com>
To:     rafael@kernel.org
Cc:     devel@acpica.org, junming@nfschina.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: Delete the initialization value
Date:   Mon, 29 Aug 2022 11:05:54 +0800
Message-Id: <20220829030555.22418-1-junming@nfschina.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAJZ5v0jVpCiwscgVQqS3yEwGaHUCPzR9pNDjt6qY6U4jJubt_A@mail.gmail.com>
References: <CAJZ5v0jVpCiwscgVQqS3yEwGaHUCPzR9pNDjt6qY6U4jJubt_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yes,just your said!
