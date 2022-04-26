Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C79C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 11:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349678AbiDZLzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 07:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiDZLzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:55:12 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016656B0AA;
        Tue, 26 Apr 2022 04:52:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6C02D4FA;
        Tue, 26 Apr 2022 11:52:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6C02D4FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650973925; bh=3ZzQrlw1NQbrjpZwAUYdsefYcABLAR3rDhbIC83lg5o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ejf3vPkCoDZZPjUag3HzOItIi90qAHWh2ynOOpEwwfuogWHblVC/OxlqlP6rYMFXz
         j47hh175m1IdOgegDPgXeK/DkeKXPye9wmEErrdDJ/qqoP0DYlOZgzaS0ug+ulgxko
         8VN/uEeVoEQme/8Qbov/oZXu1PO8UciBwK1BSf8GLqny/UTjnWGcsajWDcKLSJtDli
         GGnOyfZMK3ERJy7jbrs5slBcrhRjGTT658GsUbi/rH9BdXHh4sbEEIsyK7/SbxDkKB
         IUWJT22pFhI6sYPQ+4p0KB5sTR1zIFaj+Uvg3ZuiOZet84l4cFVcoLk5aIYY//ae21
         G6YnRFfCNG1/g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Haowen Bai <baihaowen@meizu.com>, alexs@kernel.org,
        siyanteng01@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        siyanteng@loongson.cn, Haowen Bai <baihaowen@meizu.com>
Subject: Re: [PATCH 0/2] sync with original text
 Documentation/vm/page_owner.rst
In-Reply-To: <1650956829-31013-1-git-send-email-baihaowen@meizu.com>
References: <1650956829-31013-1-git-send-email-baihaowen@meizu.com>
Date:   Tue, 26 Apr 2022 05:52:04 -0600
Message-ID: <8735i0dpuj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haowen Bai <baihaowen@meizu.com> writes:

> This patches series will sync the translation of zh_CN as below:

So I got two sets of these patches sent within minutes...so I'm not sure
what to do with them.  Why did you send them twice.

Additionally:

 - Please put a version number on your patch postings

 - A brief note (below the "---") line on what changed is helpful to
   reviewers and maintainers alike.

Thanks,

jon
