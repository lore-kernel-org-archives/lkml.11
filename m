Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE471C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 10:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiEPK12 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiEPK1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:27:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB3162F4;
        Mon, 16 May 2022 03:27:24 -0700 (PDT)
Message-ID: <20220516101901.475557433@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652696841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j7+SEaG22y86oiQDofQYoIZSbt/LwEsJzpV9z7EO1eI=;
        b=xvd46nbolPvlZD1EZvzgk3fI3dALuSgRRpx4dfljkrojWv9Cy+ZsGPIM7MPpSBMQgE8pcD
        szHMwyF0EmlnzL89Wt8XjOIjTirhREgZeUoh/5ksasqsaR/R155NBUnMMRZbihp4gSuJMs
        maNjsQ4sp9uLt5fKYQVe+CBVBWXBIcigwG6sMoDwhOe+VrxthJVeNAmw84hplEa+N9ucmh
        ljYh9CuKXOAY6oUjKaYjS68iy2zmGI/BPQ8Z/mZ4Au4p0Ojc09+tCsNXUm6tGgAwrsfHOZ
        Fh5N97NS5MrKg0O54iVXGpzFNg2+WJqjnWR82tpZ4o9WWbYcfKBEWfQW5ucd0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652696841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j7+SEaG22y86oiQDofQYoIZSbt/LwEsJzpV9z7EO1eI=;
        b=PmzjwdOipsu+dv4S+KY9mCFdUJBn7Ogt6JT4MzFn3cf5zz6qbrATdlOn+H5ydo6aEn1RxD
        Yqinny8z0+jdmnCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch 0/9] scripts/spdxcheck: Better statistics and exclude handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon, 16 May 2022 12:27:21 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c3BkeGNoZWNrIC12IG91dHB1dCBpcyBqdXN0IHByb3ZpZGluZyBiYXNpYyBzdGF0aXN0aWNzLCBi
dXQgbGFja3MgcGVyCmRpcmVjdG9yeSBzdGF0aXN0aWNzLgoKRmluZGluZyBmaWxlcyB3aXRob3V0
IFNQRFggaWRlbnRpZmllcnMgaXMgY3VtYmVyc29tZSB3aXRoIHNwZHhjaGVjaywgdGhvdWdoCml0
IGhhcyBhbGwgdGhlIGluZm9ybWF0aW9uIHJlcXVpcmVkLgoKVGhlIGV4Y2x1ZGUgb2YgZmlsZXMg
YW5kIGRpcmVjdG9yaWVzIGlzIGhhcmRjb2RlZCBpbiB0aGUgc2NyaXB0IHdoaWNoIG1ha2VzCml0
IGhhcmQgdG8gbWFpbnRhaW4gYW5kIHRoZSBpbmZvcm1hdGlvbiBjYW5ub3QgYmUgYWNjZXNzZWQg
YnkgZXh0ZXJuYWwgdG9vbHMuCgpUaGUgZm9sbG93aW5nIHNlcmllcyBhZGRyZXNzZXMgdGhpcyBi
eSBhZGRpbmc6CgogMSkgRGlyZWN0b3J5IHN0YXRpc3RpY3MKCiAgICBJbmNvbXBsZXRlIGRpcmVj
dG9yaWVzOiBTUERYIGluIEZpbGVzCiAgICAuLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA6ICAgICA2IG9mICAgIDEzICAgNDYlCiAgICAuL0RvY3VtZW50YXRpb24gICAgICAgICAgICAg
ICAgICA6ICA0MDk2IG9mICA4NDUxICAgNDglCiAgICAuL2FyY2ggICAgICAgICAgICAgICAgICAg
ICAgICAgICA6IDEzNDc2IG9mIDE2NDAyICAgODIlCiAgICAuL2Jsb2NrICAgICAgICAgICAgICAg
ICAgICAgICAgICA6ICAgMTAwIG9mICAgMTAxICAgOTklCiAgICAuL2NlcnRzICAgICAgICAgICAg
ICAgICAgICAgICAgICA6ICAgIDExIG9mICAgIDE0ICAgNzglCiAgICAuL2NyeXB0byAgICAgICAg
ICAgICAgICAgICAgICAgICA6ICAgMTQ1IG9mICAgMTc2ICAgODIlCiAgICAuL2RyaXZlcnMgICAg
ICAgICAgICAgICAgICAgICAgICA6IDI0NjgyIG9mIDMwNzQ1ICAgODAlCgogMikgVGhlIGFiaWxp
dHkgdG8gc2hvdyBmaWxlcyB3aXRob3V0IFNQRFgKCiAgICBGaWxlcyB3aXRob3V0IFNQRFg6CiAg
ICAuL2tlcm5lbC9jcHUuYwogICAgLi9rZXJuZWwva21vZC5jCiAgICAuL2tlcm5lbC9yZWxheS5j
CgogMykgQSBmaWxlIGJhc2VkIGhhbmRsaW5nIGZvciBleGNsdWRlIHBhdHRlcm5zCgpUaGFua3Ms
CgoJdGdseAo=
