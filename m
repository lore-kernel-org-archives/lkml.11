Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D498C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 23:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiDLXaN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiDLX2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:28:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1ADE0A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9864161CAC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB42C385A1;
        Tue, 12 Apr 2022 22:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649802663;
        bh=2jF5yQBTQuAeU0sIAjlvtCV8brbLDPSWeE65/+EM/fA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WeWso9pR2D03KngfPz3S0DnZHAR7yIHe09D7nHgudcPt4MuOZq6WM8+F1JY1Y0eOr
         mV2TLJmJx6kaJaHLj2NcOdKvty9a6YGtHp+yjXznFavaaRCBx9FuUdg7m+0K84+dsh
         9H63yXZjICmkAaTzKjYoHLCJjhoT7U6vwEneEqco=
Date:   Tue, 12 Apr 2022 15:31:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     <seanga2@gmail.com>, <sfr@canb.auug.org.au>,
        <linux-kernel@vger.kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        Yinan Zhang <zhangyinan2019@email.szu.edu.cn>,
        Chongxi Zhao <zhaochongxi2019@email.szu.edu.cn>,
        Yuhong Feng <yuhongf@szu.edu.cn>,
        Yongqiang Liu <liuyongqiang13@huawei.com>
Subject: Re: [PATCH] tools/vm/page_owner: support debug log to avoid huge
 log print
Message-Id: <20220412153101.1c05e00ed994982555d2fd9e@linux-foundation.org>
In-Reply-To: <1649672446-5685-1-git-send-email-baihaowen@meizu.com>
References: <1649672446-5685-1-git-send-email-baihaowen@meizu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 18:20:46 +0800 Haowen Bai <baihaowen@meizu.com> wrote:

> As normal usage, tool will print huge parser log and spend a lot of
> time printing, so it would be preferable add "-d" debug control to avoid
> this problem.
> 

Seems sensible.

Documentation/vm/page_owner.rst is getting out of date.  Sometime could
someone please go through it and check that everything is correct and
current?
