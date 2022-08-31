Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D57CECAAD1
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 17:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiHaRkV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiHaRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:39:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7BDF671;
        Wed, 31 Aug 2022 10:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FB53B82208;
        Wed, 31 Aug 2022 17:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D643C433D6;
        Wed, 31 Aug 2022 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967569;
        bh=PwQaKU6ly8iw25PA9I2YCpX/w6FyZ00byO8ha9IXWiA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IOQsFM+AScSzALQAPJ2iYWMuK6yw71yQVhLbeMvYzn0Opn48vgxqG4orO5wBhYQ9L
         hswnwXkkfY+BXg6Od4PiiomH0HvWGyCCQNpSkdKAKUWMrEvyZC/rzP4WTVgYwCeWtp
         QKqcJWKyhhhjqzkZFdabiUoRCpxv8IMeizu3XllqMzOiaV00O0gOmBCKts5vj6tcX8
         Q32e9ypjZ3j2y/5j7Vwyr+eirnYN920LRy73iR8h1ElknHIwksGQNR6ghUVhr+CD1o
         PwhAv7bYXsi84IkV5PZ/XJCPojxEcse6J6XqxaVaP6/k2eHBPOu/+i5Ola/OJPNzfD
         ytcGSsLPuDeqg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1655004286-11493-3-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com> <1655004286-11493-3-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v6 02/10] spmi: pmic-arb: handle spurious interrupt
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, tglx@linutronix.de, maz@kernel.org
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2022 10:39:27 -0700
User-Agent: alot/0.10
Message-Id: <20220831173929.1D643C433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2022-06-11 20:24:38)
> Call handle_bad_irq() when the summary interrupt is fired spuriously.
>=20
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

Applied to spmi-next
