Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88F4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 11:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiGRLpD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiGRLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:45:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E221821
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+L6TIBuhM8SDQZFxH8w/0wKMYUW7md/jtv1lI3lPGpo=; b=gXF+oZ+xZwQbo1XU4jxWlvG18V
        UfPFOQdpEoDBhVWwsJjvTie8uZxaEC6yBLHUIulG6WdVC8cdVhllYADwylL73P1eI8+p0ZKmvkOZ9
        mIEVshXJA1pxwEwFneo9oTmhvvDE2YNKnQzS30C+hAaQSJKy4j5G2N72IoQwN8a+XoLKsUVVXMKDX
        3SpWsQA3bSeRevZTbioX4wFdCamwll7OYRIPfelWd2xRV3A2y8Vapyf9Nnimo4VqO1yactXw0+Irk
        +TDCWvEyF34FPX80EBTGatmWD6BufUYCM942R7NSlalaTnNOLn0Nv7Q169VyKzoU2TKEy9Y73TV2S
        ejcSoCDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDPBD-00CeVA-Qb; Mon, 18 Jul 2022 11:44:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78574980299; Mon, 18 Jul 2022 13:44:47 +0200 (CEST)
Date:   Mon, 18 Jul 2022 13:44:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     puwen@hygon.cn
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: retbleed on hygon
Message-ID: <YtVHr1jDOtUXYF0Z@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pu Wen,

Now that retbleed is public could you please review the patches in
question and clarify the situation vs Hygon please? For development I've
assumed Hygon is basically Zen1 wrt this issue.

Kind regards,

Peter
