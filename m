Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA904C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 00:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiGFAsz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 20:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGFAsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:48:53 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01DD4167D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 17:48:51 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id B366F1E80D40;
        Wed,  6 Jul 2022 08:46:40 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0-1CPv_Kj2np; Wed,  6 Jul 2022 08:46:38 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 0F5301E80CDE;
        Wed,  6 Jul 2022 08:46:38 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     samuel.thibault@ens-lyon.org
Cc:     chris@the-brannons.com, kirk@reisers.ca,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        w.d.hubbs@gmail.com, zeming@nfschina.com
Subject: Re: [PATCH] accessibility/speakup/speakup_acnt: Add header file macro definition
Date:   Wed,  6 Jul 2022 08:48:23 +0800
Message-Id: <20220706004824.2966-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220705111621.smcxnfx45ai7vixy@begin>
References: <20220705111621.smcxnfx45ai7vixy@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you very much for your approval. 
I continue to add macros to speakup_dtlk.h and any header files I could add.

