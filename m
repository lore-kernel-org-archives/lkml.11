Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA57C433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 16:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiCCQGx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiCCQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:06:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01790198D2B;
        Thu,  3 Mar 2022 08:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646323530;
        bh=D9W07+OUMPXR+k9aCYXbl5HFYe+LbU3RKRHJ4qCmUZs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QHh6XtUf+gkd7zsLH65TjCAokeMYNZ/GYJ2qPRNmeeam8OJa44RsoDG4wWiQH4SBU
         b7mpi0rkgAoi8afbuQSEyXAeboWcPyp5j6tgAH4zl8HuGMYK9w28sRzStHx7htw2fK
         KYeUVOdmZGi22OlngNoH+NBKtgxBGStl+hx+lvik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.125] ([217.61.154.125]) by web-mail.gmx.net
 (3c-app-gmx-bs69.server.lan [172.19.170.214]) (via HTTP); Thu, 3 Mar 2022
 17:05:29 +0100
MIME-Version: 1.0
Message-ID: <trinity-3548fe76-aeda-487b-85cb-a20f012e6526-1646323529283@3c-app-gmx-bs69>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: [PATCH v4 6/8] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 3 Mar 2022 17:05:29 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220228135700.1089526-7-pgwipeout@gmail.com>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
 <20220228135700.1089526-7-pgwipeout@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:OTSJ7vnq/1y0cm7ECft7B2tnXkINN1XvaqtYb7IN1VdmMfKEEaGIIQFQkKEZ/NQ8UwKPj
 pVd9Kwpgv2wl/7qG2R/EQl1RZsQUqs2+pqZEtNR0FqUIQk0IGNEdVze07a0jp5ynSYiqeLNRiSF8
 7FyjSckjXpRD42/3cPf5ZsHS4zWvVqWgyjZzCOcAsv2rOseHWRSm9Gw6ORVihnXuZ+LAVqkNUZxf
 mDtZY5AMpWjjpOUwqNkelBVoZn5yTVqtQOfWf8drPIYXvshoDl85LSZ7KLbfDew8FUwj1LCKP+bk
 2o=
X-UI-Out-Filterresults: notjunk:1;V03:K0:lxoU31qzXBQ=:Lp28EmH3kffIc5BSoFD/y/
 xnIsubJq3YSiF8haDVld0baUcsXfNe56uRR7taGOeVBrMPF+bUeDqJetqdTHyfQOottRjGI70
 kwNNJJkUPx1dBDicEENJjAerI+l4ir/v2wQ/AhsCiKCobyUnigbwWiS3FVvmiw7Q/KU6HRz10
 U4d9jaHMrBH9XSrBwT1h8Q2ZkkN3Z82y0US/V+eqhSHC/xzH8qDQ3lQLU6/iR+CsKkYBZY8Bt
 257Wiz5/knrbjk7cjyke44NsdWvhRb1XY5aK8lVEuv5SkS6Ojs7sSYAVcVFnabMs8vtdOISqg
 AjV63yyxpYAg00N+nl2DGrJZfI4J0TzYpfltSQL+0dB3/O6/ahqJuEnQqaKSmuDOVqEMDlfTa
 qpELMHXRpLny5joH/htSRVzlfObA1UnjIpUfqsWaDqlGTIDsXdNqwMLAoSwZlRhVdAHNrTyoU
 vzl5ydgEVWCN/jKzH31WRcsWn0iVYp2yBoR8lHZVqIzTvCSly4P/PuSGgo/g1WReb9SADLM+Q
 vuB9dMwsRzhQ1DxEQFGR061eQ2KchEpDrzpEVL/e0bo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested this Series on my rk3568 Bananapi R2 Pro v00

Tested-by: Frank Wunderlich <frank-w@public-files.de>

regards Frank
