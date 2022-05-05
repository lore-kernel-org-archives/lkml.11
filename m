Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B308C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 15:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381367AbiEEPcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 11:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiEEPb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:31:57 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 536695BE5F;
        Thu,  5 May 2022 08:28:17 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 9C2931E80D1C;
        Thu,  5 May 2022 23:23:41 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VxJ5tpqwnLGW; Thu,  5 May 2022 23:23:39 +0800 (CST)
Received: from localhost.localdomain (unknown [111.193.128.65])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id EA16C1E80C9B;
        Thu,  5 May 2022 23:23:38 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     mail@maciej.szmigiero.name
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        kunyu@nfschina.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCH] x86: Function missing integer return value
Date:   Thu,  5 May 2022 23:28:02 +0800
Message-Id: <20220505152803.101762-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <fdd2d7e2-cf7c-4bfd-39d2-af5a3cf60b26@maciej.szmigiero.name>
References: <fdd2d7e2-cf7c-4bfd-39d2-af5a3cf60b26@maciej.szmigiero.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, senior, I've considered break before, but I'm not sure if I want to execute more instructions.   
Query break executed one more NOP instruction.

